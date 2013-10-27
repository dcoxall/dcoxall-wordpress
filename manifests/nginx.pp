class wordpress::nginx {

  class {"::nginx":}

  file {"/etc/nginx/wordpress.d/":
    ensure => directory,
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

  ::nginx::resource::upstream {"php":
    ensure => present,
    members => [
      "unix:/tmp/php-fpm.sock",
    ],
  }

  ::nginx::resource::vhost {"wordpress":
    ensure => present,
    www_root => "/vagrant",
    use_default_location => false,
    server_name => [
      "_",
    ],
    listen_options => "default",
    require => [
      File["/etc/nginx/wordpress.d/restrictions.conf"],
      File["/etc/nginx/wordpress.d/wordpress.conf"],
    ],
    include_files => [
      "/etc/nginx/wordpress.d/restrictions.conf",
      "/etc/nginx/wordpress.d/wordpress.conf",
    ],
  }

}
