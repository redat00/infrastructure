# @summary class to deploy redat.me website.
#
# @param version
#    version for the website on github.
#
class redat_me (
  String $version = undef,
) {
  include archive

  file { '/home/www/redat.me':
    ensure => directory,
    path   => '/home/www/redat.me',
    owner  => 'root',
    group  => 'root',
  }

  archive { '/tmp/redat_me.tar.gz':
    ensure          => present,
    path            => '/tmp/redat_me.tar.gz',
    source          => "https://github.com/redat00/redat.me/releases/download/${version}/redat_me_v${version}.tar.gz",
    user            => 'root',
    group           => 'root',
    extract         => true,
    extract_path    => '/home/www/redat.me',
    extract_command => 'tar xvf %s',
    creates         => '/home/www/redat.me/config.toml',
  }
}
