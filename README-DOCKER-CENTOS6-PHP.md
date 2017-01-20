# DOCKER for LOCAL PROJECT with CENTOS & PHP
- Docker CentOS 6 & PHP (DOCKERCENTOS6PHP)
- Github 

## DEPENDENCIES
- Centos 6.x
- PHP 5.6.x
- MySQL 5.6 (DOCKERCENTOS6PHP_MYSQL_1)
- CakePHP 2x & 3x for db migration
```
# Download composer
curl -s https://getcomposer.org/installer | php
```
- ENV
```
getenv('CHIRYOKAX_MYSQL_1_PORT_3306_TCP_ADDR');
getenv('MYSQL_DATABASE');
getenv('MYSQL_USER');
getenv('MYSQL_PASSWORD');
```

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

## STARTED
- Set up local host 
```
127.0.0.1 docker.dev
```
- Init Docker
```
./docker.sh build
./docker.sh up
```

## TEST
- Access http://docker.dev/php
- PHP MySQLi connect http://docker.dev/php/mysql/mysqli.php
- PHP PDO connect http://docker.dev/php/mysql/pdo.php

## DB MIGRATION
- CakePHP is used for db migrations
```
# Init default db or project db

# Schema 
Console/cake schema dump --write database.sql
Console/cake schema generate -f
```

## DEVELOPE WITH REAL PHP PROJECT
- Clone this repo inside PHP project for update docker and its dependencies 
- Copy all file & directory in this repo to the same path with your project
```

```
- Use below command to start the docker with your project
```
./docker.sh build
./docker.sh up
./docker.sh down
./docker.sh latest // Pleae run pull request of master branch before run this command for latest version
```

## CONTRIBUTE
- Any PR to this repo is welcome
- Email me if you have any question lecaoquochung@gmail.com

## REFERENCE
- CakePHP 2x installation https://book.cakephp.org/2.0/en/installation/advanced-installation.html