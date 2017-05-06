#!/bin/sh

# project path
SCRIPT_DIR=`dirname $0`
readonly PROJECT_NAME=${PWD##*/}
readonly PROJECT_NAME_STRIP=${PROJECT_NAME//[-._]/}
readonly DOCKERCENTOS_PATH="/var/www/html/dockercentos"
readonly CAKE2X_DC="rsync -avz /var/www/html/docker/docker-centos/php/cake2x/* /var/www/html/docker/"
readonly GITIGNORE_FROM_LINE="1"
readonly GITIGNORE_TO_LINE="8"

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
        # Start the docker machine and backgroud services
        (docker-compose ps)
        ;;
    up|start)
        # Start the docker machine and backgroud services
        (docker-compose up -d)
        ;;
    down|stop|remove)
        # Stop the services, removes the containers
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
        (docker exec -it ${PROJECT_NAME_STRIP}_server_1 bash)
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
        readonly LATEST_DOCKER_CENTOS="rsync -avz --exclude-from ${DOCKERCENTOS_PATH}/docker-centos/exclude.txt ${DOCKERCENTOS_PATH}/docker-centos/* ${PATH}/"
        (docker exec -it ${PROJECT_NAME_STRIP}_server_1 bash -c "$LATEST_DOCKER_CENTOS")
        
        # update project .gitignore (no tracking docker-centos source)
        # Step 01: Update gitignore.txt to project .gitignore
        readonly UPDATE_PROJECT_GITIGNORE="sed -i -e "$aTEXTTOEND"r<(sed '1,${GITIGNORE_TO_LINE}!d' ${DOCKERCENTOS_PATH}/docker-centos/gitignore.txt) ${DOCKERCENTOS_PATH}/.gitignore"
        (docker exec -it ${PROJECT_NAME_STRIP}_server_1 bash -c "$UPDATE_PROJECT_GITIGNORE")

        # Step 02: Delete duplicate line in project .gitignore (new file)
        # awk '!seen[$0]++' .gitignore > .gitignore
        readonly DELETE_DUPLICATE="awk '!seen[$0]++' ${DOCKERCENTOS_PATH}/.gitignore > ${DOCKERCENTOS_PATH}/.gitignore"
        (docker exec -it ${PROJECT_NAME_STRIP}_server_1 bash -c "$DELETE_DUPLICATE")

        # Step 3: new project .gitignore with gitignore.txt content
        readonly SYNC_GITIGNORE="rsync -avz ${PATH}/.gitignore-a ${DOCKERCENTOS_PATH}/.gitignore"
        (docker exec -it ${PROJECT_NAME_STRIP}_server_1 bash -c "$SYNC_GITIGNORE")
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
