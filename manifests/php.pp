class wordpress::php {

  class {"::php::fpm":}

  ::php::module {"mysql":
    notify => [
      Class["::php::fpm::service"],
    ],
  }

  ::php::fpm::pool {"www-data":
    listen => "/tmp/wordpress.sock",
    listen_type => "socket",
    socket_owner => "www-data",
    socket_group => "www-data",
  }

}
