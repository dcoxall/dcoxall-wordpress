# == Class: wordpress
#
# Full description of class wordpress here.
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
