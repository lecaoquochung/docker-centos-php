[![Stories in Ready](https://badge.waffle.io/lecaoquochung/docker-centos.png?label=ready&title=Ready)](https://waffle.io/lecaoquochung/docker-centos)
# DOCKER CENTOS for PROJECT DEVELOPMENT
- Docker CentOS (DOCKERCENTOS)

## DEPENDENCIES
- git, docker, docker-compose

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
- Update your project .gitignore with file gitignore.txt
```
TODO helper CLI for automatically copy
```

## GET STARTED
- Init Docker Centos
```
./dockercentos.sh build
./dockercentos.sh up
```

- Useful CLI
```
./dockercentos.sh latest // Update latest version of this repo
./dockercentos.sh down
```

## TEST
- Apache2 test page http://localhost
- PHPINFO http://localhost/test
```
# /etc/hosts
127.0.0.1 dockercentos.dev public.dockercentos.dev
```
- http://dockercentos.dev
- http://public.dockercentos.dev

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
- Create some issue [here](https://github.com/lecaoquochung/docker-centos/issues))
- Make pull request for issue by branch name matching with issue number (Ex: branch name for PR issue-xx)
- Email me if you have any question me@lehungio.com

## VERSION
- 1.x.x: docker-compose
- x.1.x: os (centos 6)
- x.x.1: dependencies, programming languages (nodejs, php, mysql, v.v...)

## REFERENCE
- Docker CentOS https://docs.docker.com/engine/installation/linux/centos/
