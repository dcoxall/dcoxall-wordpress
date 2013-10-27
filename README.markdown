# Wordpress
A puppet module that installs all the requirements to get [Wordpress][wordpress] installed and running but using NGINX and PHP-FPM instead of the more traditional Apache and `mod_php` solution.

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
