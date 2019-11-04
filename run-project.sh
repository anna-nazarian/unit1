#!/usr/bin/env bash

ACTION=$1
LARADOCK_DIR=unit1-laradock
PROJECT_DIR=project

command_exist () {
    type $1 > /dev/null ;
}

checkLaradockData () {
    dir=$1

    if ! [ -d $dir ]; then
        git clone --branch v7.1.1 https://github.com/Laradock/laradock.git $dir

        rm -rf $dir/.git
    fi

    if ! [ -f $dir/.env ]; then

        if ! [ -f laradock.env-example ]; then
            cp $dir/env-example $dir/.env

            echo "change configs in file $dir/.env and restart command"

            exit
        fi

        cp laradock.env-example $dir/.env
    fi
}

checkProjectData () {
    dir=$1

    if ! [ -d $dir ]; then
        echo 'installing laravel framework...'
        docker run --rm -v $(pwd)/$dir:/app composer composer create-project laravel/laravel .

        echo 'laravel framework have been installed!'

        rm -f $dir/.env

        #echo "change configs in file $PROJECT_DIR/.env and restart command"

        #exit
    fi

    if ! [ -f $dir/.env ]; then

        if ! [ -f project.env-example ]; then
            cp $dir/env.example $dir/.env

            echo "change configs in file $PROJECT_DIR/.env and restart command"

            exit
        fi

        cp project.env-example $dir/.env
    fi

    echo 'project directory status: OK'
}

echo 'checking on docker package...'

if ! command_exist "docker" ; then
    echo 'For running this command setup docker at first'

    exit
fi

echo "firing command $ACTION..."

case $ACTION in
    run)
        echo 'checking laradock directory...'
        checkLaradockData $LARADOCK_DIR

        echo 'checking project directory...'
        checkProjectData $PROJECT_DIR

        cd $LARADOCK_DIR

        DOCKER_CONTAINERS="nginx mariadb adminer redis workspace mailhog"

        docker-compose up -d $DOCKER_CONTAINERS

        docker-compose exec --user=laradock workspace bash -c "composer install && php artisan config:clear && php artisan key:generate && php artisan migrate"

        echo 'App is ready. Enjoy!'
        ;;
    stop)
        cd $LARADOCK_DIR && docker-compose down
        ;;
    exec)
        cd $LARADOCK_DIR && docker-compose exec --user=laradock workspace bash
        ;;
esac
