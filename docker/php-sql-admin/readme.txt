---------------------------------------------------------------------------
STARTING
---------------------------------------------------------------------------
    use ./docker-compose.yml

    $ docker compose up (--detach)

    should work out of the box
---------------------------------------------------------------------------
LIVE EDITING & FILES
---------------------------------------------------------------------------
    files under {./data/src} CAN be edited LIVE
    just refresh the page to see your changes
    standard index.php makes a simple SQL query and displays it

    files under {./db_data} should NOT be touched
    if mariadb is causing any problems you MAY clean this folder with:
        $ sudo rm -f -R ./db_data/*
    ONLY DO THIS if you are sure you dont care to lose your db DATA!

    files under {./db_start} CAN be edited BEFORE starting the db
    this file runs on the db startup and runs any SQL inside it 
    MAY be used to make TABLES and INSERT rows into said tables
