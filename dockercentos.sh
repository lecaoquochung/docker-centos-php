#!/bin/sh

# project path
SCRIPT_DIR=`dirname $0`
readonly PROJECT_NAME=${PWD##*/}
readonly PROJECT_NAME_STRIP=${PROJECT_NAME//[-._]/}
readonly DOCKERCENTOS_PATH="/var/www/html/dockercentos"
readonly CAKE2X_DC="rsync -avz /var/www/html/docker/docker-centos/php/cake2x/* /var/www/html/docker/"
readonly GITIGNORE_FROM_LINE="1"
readonly GITIGNORE_TO_LINE="8"
readonly GITIGNORE_FILE="${DOCKERCENTOS_PATH}/.gitignore"
readonly GITIGNORE_FILE_TEXT="# Automatically created by ./dockercentos.sh latest"
readonly REPO="https://github.com/lecaoquochung/docker-centos"
readonly TIMESTAMP="date +%s"

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
            commmit - Commit a PR to docker-centos \n \
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
        readonly LATEST_DOCKER_CENTOS="rsync -avz --exclude-from ${DOCKERCENTOS_PATH}/docker-centos/exclude.txt ${DOCKERCENTOS_PATH}/docker-centos/* ${DOCKERCENTOS_PATH}/"
        (docker exec -it ${PROJECT_NAME_STRIP}_server_1 bash -c "$LATEST_DOCKER_CENTOS")
        
        # TODO issue-12
        # Step 01: update project .gitignore (no tracking docker-centos source)
        # check gitignore file existed
        #if [ -f "$GITIGNORE_FILE" ]
        #then
        #    # echo "$GITIGNORE_FILE existed."
        #    readonly UPDATE_GITIGNORE_FILE="printf  '# Automatically created by ./dockercentos.sh latest\n' >> /var/www/html/dockercentos/.gitignore"
        #    # readonly UPDATE_GITIGNORE_FILE="echo ${GITIGNORE_FILE_TEXT} >> ${GITIGNORE_FILE}"
        #else
        #    readonly UPDATE_GITIGNORE_FILE="printf '# Automatically created by ./dockercentos.sh latest\n' >> /var/www/html/dockercentos/.gitignore"
        #    # readonly UPDATE_GITIGNORE_FILE="echo ${GITIGNORE_FILE_TEXT} > ${GITIGNORE_FILE}"
        #fi

        #(docker exec -it ${PROJECT_NAME_STRIP}_server_1 bash -c "$UPDATE_GITIGNORE_FILE")
        
        # Step 02: Update gitignore.txt to project .gitignore
        # TODO check CLI in detail UPDATE_PROJECT_GITIGNORE
        # readonly UPDATE_PROJECT_GITIGNORE="sed -i -e "$aTEXTTOEND"r<(sed '1,${GITIGNORE_TO_LINE}!d' ${DOCKERCENTOS_PATH}/docker-centos/gitignore.txt) ${DOCKERCENTOS_PATH}/.gitignore"
        # (docker exec -it ${PROJECT_NAME_STRIP}_server_1 bash -c "$UPDATE_PROJECT_GITIGNORE")

        # Step 03: Delete duplicate line in project .gitignore (new file)
        # TODO check CLI in detail DELETE_DUPLICATE
        # readonly DELETE_DUPLICATE="awk '!seen[$1]++' /var/www/html/dockercentos/.gitignore > /var/www/html/dockercentos/gitignore.tmp"
        # readonly DELETE_DUPLICATE="awk '!seen[$1]++' ${DOCKERCENTOS_PATH}/.gitignore > ${DOCKERCENTOS_PATH}/gitignore.tmp" 
        # TODO can not get duplicate line in .gitignore with DELETE_DUPLICATE through helper
        # it works with CLI in docker ssh
        # (docker exec -it ${PROJECT_NAME_STRIP}_server_1 bash -c "$DELETE_DUPLICATE")

        # Step 4: new project .gitignore with gitignore.txt content
        # readonly SYNC_GITIGNORE="rsync -avz ${DOCKERCENTOS_PATH}/gitignore.tmp ${DOCKERCENTOS_PATH}/.gitignore"
        # (docker exec -it ${PROJECT_NAME_STRIP}_server_1 bash -c "$SYNC_GITIGNORE")
        ;;
    commit)
        # Reverse commit to docker-centos
        # step 01 reverse sync file & dir
        readonly REVERSE_SYNC="rsync -ruvv --include-from=${DOCKERCENTOS_PATH}/docker-centos/commit.txt ${DOCKERCENTOS_PATH}/* ${DOCKERCENTOS_PATH}/docker-centos/"
        (docker exec -it ${PROJECT_NAME_STRIP}_server_1 bash -c "$REVERSE_SYNC")

        # step 2: commit
        readonly AUTO_COMMIT="cd ${DOCKERCENTOS_PATH}/docker-centos; git commit  -a -m 'Autocommit-$(date +%s)'"
        (docker exec -it ${PROJECT_NAME_STRIP}_server_1 bash -c "$AUTO_COMMIT")

        # step 3: pull request
        # TODO config file for github auth or public key
        readonly AUTO_PUSH="cd ${DOCKERCENTOS_PATH}/docker-centos; git push origin master:autopush-$(date +%s)"
        (docker exec -it ${PROJECT_NAME_STRIP}_server_1 bash -c "$AUTO_PUSH")

        ;;
    cake2x)
        (docker exec -it ${PROJECT_NAME}_server_1 bash -c "$CAKE2X_DC")
        ;;
    *)
        echo "Unknown parameter"
        echo "Param:"
        echo "./dockercentos.sh [ps|up|down|db|ssh|build|log|restart|latest|commit|cake2x]"
        ;;
esac
