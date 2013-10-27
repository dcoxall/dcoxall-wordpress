class wordpress::nginx {

  class {"::nginx":}

  file {"/etc/nginx/wordpress.d/":
    ensure => directory,
    before => [
      Anchor["nginx::end"],
    ],
  }

  file {"/etc/nginx/wordpress.d/restrictions.conf":
    require => [
      File["/etc/nginx/wordpress.d/"],
    ],
    ensure => present,
    content => template("wordpress/nginx/restrictions.erb"),
  }

  file {"/etc/nginx/wordpress.d/wordpress.conf":
    require => [
      File["/etc/nginx/wordpress.d/"],
    ],
    ensure => present,
    content => template("wordpress/nginx/wordpress.erb"),
  }

  file {"/etc/nginx/conf.d/default.conf":
    ensure => absent,
    before => [
      Anchor["nginx::end"],
    ],
  }

  ::nginx::resource::upstream {"php":
    ensure => present,
    members => [
      "unix:/tmp/wordpress.sock",
    ],
  }

  file {"/etc/nginx/conf.d/wordpress_vhost.conf":
    ensure => present,
    content => template("wordpress/nginx/vhost.erb"),
    require => [
      File["/etc/nginx/wordpress.d/restrictions.conf"],
      File["/etc/nginx/wordpress.d/wordpress.conf"],
      File["/etc/nginx/conf.d/default.conf"],
    ],
    before => [
      Anchor["nginx::end"],
    ],
  }

}
