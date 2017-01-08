# DOCKER for LOCAL PROJECT with CENTOS & PHP
- Docker CentOS 6 & PHP
- Github 

## DEPENDENCIES
- Centos 6
- PHP 5.6.x
- MySQL 5.6

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
- Access http://docker.dev

## DEVELOPING WITH REAL PHP PROJECT
- Clone this repo inside PHP project for update docker and its dependencies 
- Copy all file & directory in this repo to the same path with your project
- Use below command to get it start
```
./docker.sh build
./docker.sh up
./docker.sh down
```

## CONTRIBUTE
- Please make PR to this repo
- Email me if you have any question lecaoquochung@gmail.com