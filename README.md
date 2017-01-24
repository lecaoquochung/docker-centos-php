# DOCKER CENTOS for LOCAL PROJECT
- Docker CentOS (DOCKERCENTOS)
- Github

## DEPENDENCIES
- Centos 6.x
- PHP 5.6.x
- MySQL 5.6 (DOCKERCENTOS_MYSQL_1)
- CakePHP 2x & 3x for db migration
```
# Download composer
curl -s https://getcomposer.org/installer | php
```

## ENV
- Default environment
```
getenv('DOCKERCENTOS_MYSQL_1_PORT_3306_TCP_ADDR');
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
./dockercentos.sh build
./dockercentos.sh up
```

## TEST
- http://localhost/docker-centos-test/

## DB MIGRATION
- CakePHP is used for db migrations
```
# Init default db or project db

# Schema
Console/cake schema dump --write database.sql
Console/cake schema generate -f
```

## DEVELOPE WITH REAL PHP PROJECT
- Clone this repo inside project source code
- Copy dockercentos.sh file in this repo to the same path with your project
```
# sammple-project/
git clone git@github.com:lecaoquochung/docker-centos.git
rsync -av docker-centos/* ./ --exclude=README.md
rsync -avz --exclude-from 'exclude.txt' docker-centos/* ./
```

- Use below command to start the docker with your project
```
./dockercentos.sh build
./dockercentos.sh up
./dockercentos.sh down
./dockercentos.sh latest // Latest version of DOCKER-CENTO6-PHP
```

## CONTRIBUTE
- Any PR to this repo is welcome
- Email me if you have any question lecaoquochung@gmail.com

## REFERENCE
- CakePHP 2x installation https://book.cakephp.org/2.0/en/installation/advanced-installation.html
- Docker CentOS https://docs.docker.com/engine/installation/linux/centos/
