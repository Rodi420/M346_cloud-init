---------------------------------------------------------------------------
METHOD 1
---------------------------------------------------------------------------
    use ./yml-only/docker-compose.yml

    $ docker compose up (--detach)

    should work out of the box
---------------------------------------------------------------------------
METHOD 2
---------------------------------------------------------------------------
    use docker run...but first build the images

    go to ./dockerfile/nc and do:
    $ docker build -t imageName1:version .

    go to ./dockerfile/db and do:
    $ docker build -t imageName2:version .

    after that you can either choose
    ./dockerfile/docker-compose.yml
    or
    ./dockerfile/auto-start.sh
    or
    $ docker run ...

     |
    \|/

    COMPOSE:
        open the yml and change lines 10 and 17 accordingly with "imageName1:version" and "imageName2:version".
        then just do $ docker compose up --detach and open your web browser on localhost:8080.
    BASH:
        change the variables $nextcloud_image and $mariadb_image to "imageName1:version" and "imageName2:version" and save.
        then just run the script and open your web browser on localhost:8080.
    DOCKER RUN:
        if you fancy not using the script you can run these commands:
        docker:
        $ docker run -d --name "mariadb" --volume mariadb:/var/lib/mysql imageName2:version
        nextcloud:
        $ docker run -d --name "nextcloud" -p 8080:80 --link mariadb:mariadb \
        --volume nextcloud-root:/var/www/html --volume nextcloud-data:/var/www/html/data --volume nextcloud-config:/var/www/html/config \
        imageName1:version

        these volumes will split the data, configs and nextcloud code for easier migration

    install wizard should automatically find the db and not ask for password etc. if not do manually.

---------------------------------------------------------------------------
