#
# @param remote_location
#    http url to download from
#
# @param mode
#    permission mode for the downloaded file
#
define remote_file (
  String $remote_location = undef,
  String $mode = '0644',
) {
  exec { "retrieve_${title}":
    command => "/usr/bin/wget -q ${remote_location} -O ${title}",
    creates => $title,
  }

  file { $title:
    mode    => $mode,
    require => Exec["retrieve_${title}"],
  }
}
