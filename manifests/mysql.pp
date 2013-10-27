class wordpress::mysql {

  class {"::mysql::server":
    root_password => "vagrant",
    old_root_password => "",
  }

  mysql::db {"wordpress":
    user     => "wordpress",
    password => "wordpress",
    host     => "localhost",
    grant    => ["ALL"],
  }

}
