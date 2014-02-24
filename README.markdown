# Wordpress
A puppet module that installs all the requirements to get [Wordpress][wordpress] installed and running but using NGINX and PHP-FPM instead of the more traditional Apache and `mod_php` solution.

## What does it do?
This module does NOT install wordpress. It does however create an NGINX and PHP-FPM environment in which wordpress works. Based on the recommended set-up described on wordpress.org this module prepares the nginx configuration and php-fpm pool to correctly serve a wordpress installation.

Part of the setup also includes a MySQL installation with a database that can be used with the following details:

- Username: wordpress
- Password: wordpress
- Host: localhost
- Database: wordpress

These options can be overridden as shown below. The mysql user is given access to the database on a wildcard as well as localhost in the event you wish to connect externally.

### Usage
```puppet
include wordpress
# or
class { "wordpress": }
```

#### Customising
```puppet
class { "wordpress":
  cache    => false,       # Static asset caching in NGINX (default: false)
  user     => 'wordpress', # DB User (default: wordpress)
  password => 'wordpress', # DB Pass (default: wordpress)
  database => 'wordpress', # DB Name (default: wordpress)
}
```

### Contribute
Any contributions are welcome. There are no crazy requirements to contribute.

1. Fork the project
2. Make your changes
3. Create a Pull Request

[wordpress]: http://wordpress.org/
