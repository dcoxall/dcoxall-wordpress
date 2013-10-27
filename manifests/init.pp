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

  class {"wordpress::php":
    require => [ Class["wordpress::mysql"] ],
  }

  class {"wordpress::nginx":
    require => [ Class["wordpress::nginx"] ],
  }

}
