#
#
class protonweb {
  include nginx

  class { 'dehydrated':
    contact_email    => 'reno@redat.me',
    challengetype    => 'http-01',
    cron_integration => true,
  }

  file { '/home/logs/nginx':
    ensure => directory,
    path   => '/home/logs/nginx',
    owner  => 'root',
    group  => 'root',
  }

  # redat.me website

  file { '/home/logs/nginx/redat.me':
    ensure => directory,
    path   => '/home/logs/nginx/redat.me',
    owner  => 'root',
    group  => 'root',
  }

  nginx::resource::location { 'redat-me-dehydrated':
    ensure         => present,
    location       => '^~ /.well-known/acme-challenge',
    location_alias => '/home/dehydrated/.acme-challenges',
    server         => 'redat.me',
  }

  nginx::resource::server { 'redat.me':
    ensure       => present,
    server_name  => ['redat.me'],
    www_root     => '/home/www/redat.me',
    ssl          => true,
    ssl_cert     => '/home/dehydrated/certs/redat.me/fullchain.pem',
    ssl_key      => '/home/dehydrated/certs/redat.me/privkey.pem',
    ssl_redirect => true,
    access_log   => '/home/logs/nginx/redat.me/https_redat_me.access.log',
    error_log    => '/home/logs/nginx/redat.me/https_redat_me.error.log',
  }

  dehydrated::certificate { 'redat.me':
    domains => ['redat.me'],
  }

  # deploy redat_me website
  class { 'redat_me':
    version => '2.0.1',
  }

  # renaudduret.fr website

  file { '/home/logs/nginx/renaudduret.fr':
    ensure => directory,
    path   => '/home/logs/nginx/renaudduret.fr',
    owner  => 'root',
    group  => 'root',
  }

  nginx::resource::location { 'renaudduret-fr-dehydrated':
    ensure         => present,
    location       => '^~ /.well-known/acme-challenge',
    location_alias => '/home/dehydrated/.acme-challenges',
    server         => 'renaudduret.fr',
  }

  nginx::resource::server { 'renaudduret.fr':
    ensure       => present,
    server_name  => ['renaudduret.fr'],
    www_root     => '/home/www/renaudduret.fr',
    ssl          => true,
    ssl_cert     => '/home/dehydrated/certs/renaudduret.fr/fullchain.pem',
    ssl_key      => '/home/dehydrated/certs/renaudduret.fr/privkey.pem',
    ssl_redirect => true,
    access_log   => '/home/logs/nginx/renaudduret.fr/https_renaudduret_fr.access.log',
    error_log    => '/home/logs/nginx/renaudduret.fr/https_renaudduret_fr.error.log',
  }

  dehydrated::certificate { 'renaudduret.fr':
    domains => ['renaudduret.fr'],
  }
}
