# Wordpress
A puppet module that installs all the requirements to get [Wordpress][wordpress] installed and running but using NGINX and PHP-FPM instead of the more traditional Apache and `mod_php` solution.

## What does it do?
This module does NOT install wordpress. It does however create an NGINX and PHP-FPM environment in which wordpress works. Based on the recommended set-up described on wordpress.org this module prepares the nginx configuration and php-fpm pool to correctly serve a wordpress installation.

Part of the setup also includes a MySQL installation with a database that can be used with the following details:

- Username: wordpress
- Password: wordpress
- Host: 127.0.0.1
- Database: wordpress

### Usage
Currently there are no configurable settings (this will change) so it is as simple as:

```puppet
include wordpress
# or
class {"wordpress":}
```

### Contribute
Any contributions are welcome. There are no crazy requirements to contribute.

1. Fork the project
2. Make your changes
3. Create a Pull Request

[wordpress]: http://wordpress.org/
