#!/bin/sh

# project path
SCRIPT_DIR=`dirname $0`
readonly PROJECT_NAME=${PWD##*/}
readonly LATEST_DOCKER_CENTOS="rsync -avz --exclude-from /var/www/html/docker/docker-centos/exclude.txt /var/www/html/docker/docker-centos/* /var/www/html/docker/"
readonly CAKE2X_DC="rsync -avz /var/www/html/docker/docker-centos/php/cake2x/* /var/www/html/docker/"

case $1 in
    help|--help)
        echo "
            Usage: ./dockercentos.sh [up|down] \n\n \
            ps      - List containers \n \
            up      - Starts the services in the background \n \
            down    - Stops the services, removes the containers \n \
            db      - Open mysql \n \
            ssh     - Connect SSH \n \
            build   - Docker compose build \n \
            log     - Check service logs \n \
            restart - Restart services \n \
            latest  - Update docker and its dependencies \n \
            cake2x  - Update docker and its dependencies \n
        "
        ;;
    ps)
            # Starts the docker machine and backgroud services
        (docker-compose ps)
        ;;
    up|start)
        # Starts the docker machine and backgroud services
        (docker-compose up -d)
        ;;
    down|stop|remove)
        # Stops the services, removes the containers
        (docker-compose down)
        (docker volume rm dockercentos-server)
        (docker volume rm dockercentos-mysql)
        (docker volume rm dockercentos-memcached)
        ;;
    db)
        # Open mysql
        (mysql -u docker -pdocker -Ddocker -h 127.0.0.1)
        ;;
    ssh)
        # Connect to SSH
        (docker exec -it ${PROJECT_NAME}_server_1 bash)
        ;;
    build)
        # Build image in Dockerfile
        (docker-compose build)
        ;;
    log)
        # Check service logs
        (docker-compose logs)
        ;;
    restart)
        # Restart services
        (docker-compose restart)
        ;;
    latest)
        # (docker-compose run server bin/bash -c "$LATEST_DOCKER")
        (docker exec -it ${PROJECT_NAME}_server_1 bash -c "$LATEST_DOCKER_CENTOS")
        ;;
    cake2x)
        (docker exec -it ${PROJECT_NAME}_server_1 bash -c "$CAKE2X_DC")
        ;;
    *)
        echo "Unknown parameter"
        echo "Param:"
        echo "./dockercentos.sh [ps|up|down|db|ssh|build|log|restart|latest|cake2x]"
        ;;
esac
