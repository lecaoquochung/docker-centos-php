# DOCKER CENTOS for DEVELOPMENT PROJECT
- Docker CentOS (DOCKERCENTOS)

## DEPENDENCIES
- Centos 6.x
- PHP 5.6.x
- MySQL 5.6 (DOCKERCENTOS_MYSQL_1)

## INIT
- Clone this repo inside any project that need docker centos as local development
```
# path: cd your-project
git clone git@github.com:lecaoquochung/docker-centos.git
```
- Run this command for sync docker-centos to your project path
```
# rsync help (?)
rsync -avz --exclude-from 'docker-centos/exclude.txt' docker-centos/* ./
```
- Init database: Put your project database as sql in path below (it will be automatically bootstrapped)
```
Path: your-project/docker/db/init.d/
```

## GET STARTED
- Init Docker Centos
```
./dockercentos.sh build
./dockercentos.sh up
```

- Update and stop it
```
./dockercentos.sh latest // Update latest version of this repo
./dockercentos.sh down
```

## TEST
- Running test http://localhost/docker-centos-test/
- PHP Project
```
- PHP MySQLi connect http://localhost/php/mysql/mysqli.php
- PHP PDO connect http://localhost/php/mysql/pdo.php
```

## ENV
- Default environment
```
DOCKERCENTOS_MYSQL_1_PORT_3306_TCP_ADDR
MYSQL_DATABASE
MYSQL_USER
MYSQL_PASSWORD
```

## SUPPORT FRAMEWORK
- CakePHP 2
```
```

## CONTRIBUTE & QUESTION
- Make PR to this repo
- Email me if you have any question lecaoquochung@gmail.com

## REFERENCE
- Docker CentOS https://docs.docker.com/engine/installation/linux/centos/
