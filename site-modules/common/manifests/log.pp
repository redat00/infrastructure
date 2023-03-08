#
#
class common::log {
  file { '/home/logs':
    ensure => directory,
    path   => '/home/logs',
    group  => 'root',
    owner  => 'root',
  }
}
