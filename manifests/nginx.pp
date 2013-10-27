class wordpress::nginx {

  class {"::nginx":}

  file {"/etc/nginx/wordpress.d/":
    ensure => directory,
    require => [
      Class["::nginx"],
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
    require => [
      Class["::nginx"],
    ],
  }

  ::nginx::resource::upstream {"php":
    ensure => present,
    members => [
      "unix:/tmp/php-fpm.sock",
    ],
  }

  file {"/etc/nginx/conf.d/wordpress_vhost.conf":
    ensure => present,
    template => template("wordpress/nginx/vhost.erb"),
    require => [
      File["/etc/nginx/wordpress.d/restrictions.conf"],
      File["/etc/nginx/wordpress.d/wordpress.conf"],
      File["/etc/nginx/conf.d/default.conf"],
    ],
    notify => [
      Class["::nginx::service"]
    ],
  }

}
