---------------------------------------------------------------------------
METHOD 1
---------------------------------------------------------------------------
    use ./yml-only/docker-compose.yml

    $ docker compose up (--detach)

    should work out of the box (DOES NOT INCLUDE CUSTOM VOLUME LOCATIONS)
---------------------------------------------------------------------------
METHOD 2
---------------------------------------------------------------------------
    use ./dockerfile/auto-start.sh

    $ sudo ./dockerfile/auto-start.sh

    choose option "Build and Run" and follow instructions
---------------------------------------------------------------------------
METHOD 3
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

    COMPOSE (DOES NOT INCLUDE CUSTOM VOLUME LOCATIONS):
        open the yml and change lines 10 and 17 accordingly with "imageName1:version" and "imageName2:version".
        then just do $ docker compose up --detach and open your web browser on localhost:8080.

    BASH:
        change the variables $nc_image and $db_image to "imageName1:version" and "imageName2:version" and save.
        if you want to you can change $dir_name to change where to store your volumes later.
        then just run the script and choose NOT to build the images again and open your web browser on localhost:8080.

    DOCKER RUN (DOES NOT INCLUDE CUSTOM VOLUME LOCATIONS):
        if you fancy not using the script you can run these commands:
        mariadb:
        $ docker run -d --name "mariadb" --volume mariadb:/var/lib/mysql imageName2:version
        nextcloud:
        $ docker run -d --name "nextcloud" -p 8080:80 --link mariadb:mariadb \
        --volume nextcloud-root:/var/www/html --volume nextcloud-data:/var/www/html/data --volume nextcloud-config:/var/www/html/config \
        imageName1:version

        these volumes will split the data, configs and nextcloud code for easier migration

    install wizard should automatically find the db and not ask for password etc. if not do manually.

---------------------------------------------------------------------------
