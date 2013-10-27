# == Class: wordpress
#
# Installs and configures NGINX and PHP-FPM
# for serving Wordpress blogs.
#
# === Examples
#
#  class { "wordpress":}
#
# === Authors
#
# Darren Coxall <darren@darrencoxall.com>
#
class wordpress {

  class {"wordpress::mysql":}

  exec {"apt-get update":
    command => "/usr/bin/apt-get update",
  }

  class {"wordpress::php":
    require => [
      Class["wordpress::mysql"],
      Exec["apt-get update"],
    ],
  }

  class {"wordpress::nginx":
    require => [
      Class["wordpress::php"],
    ],
  }

}
