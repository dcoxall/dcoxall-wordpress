class wordpress::mysql(
  $user     = 'wordpress',
  $password = 'wordpress',
  $database = 'wordpress',
) {
  package { [
    "mysql-server",
    "php5-mysql",
  ]: }

  exec { "mysql_install_db":
    unless  => "test -d /var/lib/mysql",
    require => Package["mysql-server"],
  }
  exec { "create_db":
    command => "mysql -u root -e 'CREATE DATABASE $database;'",
    unless  => "mysql -u root $database -e 'SELECT 1;'",
    require => Exec["mysql_install_db"],
  }
  exec { "create_user":
    command => "mysql -u root -e \"
FLUSH PRIVILEGES;
CREATE USER '$user'@'localhost' IDENTIFIED BY '$password';
GRANT ALL PRIVILEGES ON $database.* TO '$user'@'localhost';
CREATE USER '$user'@'%' IDENTIFIED BY '$password';
GRANT ALL PRIVILEGES ON $database.* TO '$user'@'%';
\"",
    unless  => "mysql -u $user --password=$password $database -e 'SELECT 1;'",
    require => Exec["create_db"],
  }
}
