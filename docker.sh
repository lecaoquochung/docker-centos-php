#!/bin/sh

# project path
SCRIPT_DIR=`dirname $0`

case $1 in
    help|--help)
        echo "
            Usage: ./docker.sh [up|down] \n\n \
            ps      - List containers \n \
            up      - Starts the services in the background \n \
            down    - Stops the services, removes the containers \n \
            db      - Open mysql \n \
            ssh     - Connect SSH \n \
            build   - Docker compose build \n \
            log     - Check service logs \n \
            restart - Restart services \n \
            latest  - Update docker and its dependencies \n
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
        ;;
    db)
        # Open mysql
        (mysql -u docker -pdocker -Ddocker -h 127.0.0.1)
        ;;
    ssh)
        # Connect to SSH
        (docker exec -it dockercentos6php_server_1 bash)
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
        # Update docker & its dependencies to the latest version
        LATEST_DOCKER="cp -uvrf /var/www/html/docker/docker-centos6-php/* /var/www/html/docker/"
        (docker-compose run server bin/bash -c "$LATEST_DOCKER")
        ;;
    *)
        echo "unknown command"
        echo "Usage:"
        echo "./docker.sh [ps|up|down|db|ssh|build|log|restart|latest]"
        ;;
esac
