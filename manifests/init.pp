# == Class: wordpress
#
# Installs and configures NGINX and PHP-FPM
# for serving Wordpress blogs.
#
# === Examples
#
#  class { "wordpress":
#    cache    => true,        # Enable/disable static asset caching... default false
#    database => 'wordpress', # Database name... default wordpress
#    user     => 'wordpress', # Database user name... default wordpress
#    password => 'wordpress', # Database user password... default wordpress
#  }
#
# === Authors
#
# Darren Coxall <darren@darrencoxall.com>
#
class wordpress(
  $cache    = false,
  $database = 'wordpress',
  $user     = 'wordpress',
  $password = 'wordpress',
) {
  Exec {
    path => "/usr/bin",
  }

  exec { "apt-get update": }

  class { "wordpress::mysql":
    database => $database,
    user     => $user,
    password => $password,
    require  => Exec["apt-get update"]
  }

  class { "wordpress::nginx":
    cache   => $cache,
    require => Exec["apt-get update"]
  }

  class { "wordpress::php":
    require => Exec["apt-get update"]
  }
}
