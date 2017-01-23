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

## ENV
- Default environment
```
getenv('DOCKERCENTOS6PHP_MYSQL_1_PORT_3306_TCP_ADDR');
getenv('MYSQL_DATABASE');
getenv('MYSQL_USER');
getenv('MYSQL_PASSWORD');
```

## STARTED
- Set up local host
```
127.0.0.1 docker.dev
```

- Init Docker
```
./dockercentosphp.sh build
./dockercentosphp.sh up
```

## TEST
- http://localhost/test/

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
- Copy docker.sh file in this repo to the same path with your project
```
# php-project/
git clone git@github.com:lecaoquochung/docker-centos-php.git
cp -vrf docker-centos-php/* ./
```

- Use below command to start the docker with your project
```
./dockercentosphp.sh build
./dockercentosphp.sh up
./dockercentosphp.sh down
./dockercentosphp.sh latest // Latest version of DOCKER-CENTO6-PHP
```

## CONTRIBUTE
- Any PR to this repo is welcome
- Email me if you have any question lecaoquochung@gmail.com

## REFERENCE
- CakePHP 2x installation https://book.cakephp.org/2.0/en/installation/advanced-installation.html
- Docker images, containers, volume remove https://www.digitalocean.com/community/tutorials/how-to-remove-docker-images-containers-and-volumes
