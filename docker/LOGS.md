# CakePHP
## CakePHP 2x
```
#  composer.json
{
    "name": "schema",
    "require": {
        "cakephp/cakephp": "2.9.*"
    },
    "config": {
        "vendor-dir": "Vendor/"
    }
}

# Install
./composer.phar install

# Generate skeleton
Path: /var/www/html/docker/docker/db/schema
/var/www/html/docker/docker/db/schema/Vendor/bin/cake bake schema
```


## CakePHP latest
```
composer.phar create-project --prefer-dist cakephp/app cakephp
```

# TEST
- Access http://docker.dev/php
- PHP MySQLi connect http://docker.dev/php/mysql/mysqli.php
- PHP PDO connect http://docker.dev/php/mysql/pdo.php
