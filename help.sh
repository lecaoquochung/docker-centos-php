#!/bin/sh

# project path
SCRIPT_DIR=`dirname $0`
readonly BRAND="lihocent"
readonly PROJECT_NAME=${PWD##*/}
readonly PROJECT_NAME_STRIP=${PROJECT_NAME//[-._]/}
readonly LIHOCENT_PATH="/var/www/html/lihocent"
readonly CAKE2X_DC="rsync -avz /var/www/html/docker/docker-centos/php/cake2x/* /var/www/html/docker/"
readonly GITIGNORE_FROM_LINE="1"
readonly GITIGNORE_TO_LINE="8"
readonly GITIGNORE_FILE="${LIHOCENT_PATH}/.gitignore"
readonly GITIGNORE_FILE_TEXT="# Automatically created by ./help.sh latest"
readonly REPO="https://github.com/lecaoquochung/liho-cent"
readonly TIMESTAMP="date +%s"
readonly LOCALHOST="127.0.0.1"

case $1 in
    help|--help)
        echo "
            Usage: ./help.sh [up|down] \n\n \
            ps         - List containers \n \
            up         - Starts the services in the background \n \
            down       - Stops the services, removes the containers \n \
            db         - Open mysql \n \
            ssh        - Connect SSH \n \
            build      - Docker compose build \n \
            log        - Check service logs \n \
            restart    - Restart services \n \
            latest     - Update docker and its dependencies \n \
            commmit    - Commit a PR to docker-centos \n \
            dump       - Dump database \n \
            restore    - Restore database \n
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
        (docker volume rm ${PROJECT_NAME_STRIP}-server)
        (docker volume rm ${PROJECT_NAME_STRIP}-mysql)
        (docker volume rm ${PROJECT_NAME_STRIP}-memcached)

        ;;
    db)
        # Open mysql
        (mysql -u ${BRAND} -p${BRAND} -D${BRAND} -h 127.0.0.1)

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
        readonly LATEST_DOCKER_CENTOS="rsync -avz --exclude-from ${LIHOCENT_PATH}/${PROJECT_NAME}/exclude.txt ${LIHOCENT_PATH}/${PROJECT_NAME}/* ${LIHOCENT_PATH}/"
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
        # readonly UPDATE_PROJECT_GITIGNORE="sed -i -e "$aTEXTTOEND"r<(sed '1,${GITIGNORE_TO_LINE}!d' ${LIHOCENT_PATH}/docker-centos/gitignore.txt) ${LIHOCENT_PATH}/.gitignore"
        # (docker exec -it ${PROJECT_NAME_STRIP}_server_1 bash -c "$UPDATE_PROJECT_GITIGNORE")

        # Step 03: Delete duplicate line in project .gitignore (new file)
        # TODO check CLI in detail DELETE_DUPLICATE
        # readonly DELETE_DUPLICATE="awk '!seen[$1]++' /var/www/html/dockercentos/.gitignore > /var/www/html/dockercentos/gitignore.tmp"
        # readonly DELETE_DUPLICATE="awk '!seen[$1]++' ${LIHOCENT_PATH}/.gitignore > ${LIHOCENT_PATH}/gitignore.tmp" 
        # TODO can not get duplicate line in .gitignore with DELETE_DUPLICATE through helper
        # it works with CLI in docker ssh
        # (docker exec -it ${PROJECT_NAME_STRIP}_server_1 bash -c "$DELETE_DUPLICATE")

        # Step 4: new project .gitignore with gitignore.txt content
        # readonly SYNC_GITIGNORE="rsync -avz ${LIHOCENT_PATH}/gitignore.tmp ${LIHOCENT_PATH}/.gitignore"
        # (docker exec -it ${PROJECT_NAME_STRIP}_server_1 bash -c "$SYNC_GITIGNORE")

        ;;
    commit)
        # Reverse commit to docker-centos
        # step 01 reverse sync file & dir
        readonly REVERSE_SYNC="rsync -ruvv --include-from=${LIHOCENT_PATH}/${PROJECT_NAME}/commit.txt ${LIHOCENT_PATH}/* ${LIHOCENT_PATH}/${PROJECT_NAME}/"
        (docker exec -it ${PROJECT_NAME_STRIP}_server_1 bash -c "$REVERSE_SYNC")

        # step 2: commit
        readonly AUTO_COMMIT="cd ${LIHOCENT_PATH}/docker-centos; git commit  -a -m 'Autocommit-$(date +%s)'"
        (docker exec -it ${PROJECT_NAME_STRIP}_server_1 bash -c "$AUTO_COMMIT")

        # step 3: pull request
        # TODO config file for github auth or public key 
        # readonly AUTO_PUSH="cd ${LIHOCENT_PATH}/docker-centos; git push origin master:autopush-$(date +%s)"
        # (docker exec -it ${PROJECT_NAME_STRIP}_server_1 bash -c "$AUTO_PUSH")

        ;;
    cake2x)
        #(docker exec -it ${PROJECT_NAME}_server_1 bash -c "$CAKE2X_DC")

        ;;
    dump)
        # dump database to sql file in  sql/lihocent.sql 
        readonly DUMP_DB="mysqldump -u${BRAND} -p${BRAND} -h${LOCALHOST} ${BRAND} > ${LIHOCENT_PATH}/sql/${BRAND}.sql"
        (docker-compose exec mysql /bin/bash -c "$DUMP_DB")
        ;;
    restore)
        readonly RESTORE_DB="mysql -u${BRAND} -p${BRAND} ${BRAND} < ${LIHOCENT_PATH}/sql/${BRAND}.sql"
	    (docker-compose exec mysql /bin/bash -c "$RESTORE_DB")
        ;;
    *)
        echo "Unknown parameter"
        echo "Param:"
        echo "./dockercentos.sh [ps|up|down|db|ssh|build|log|restart|latest|commit|dump|restore]"
        
        ;;
esac
