<?php

#credentials
$host = 'mariadb';
$user = 'rta-dbuser';
$pass = '123456';
$mydatabase = 'rta-db';

#connection string
$conn = new mysqli($host, $user, $pass, $mydatabase);

#query
$sql = 'SELECT * FROM `rta-db`.`user`';

#checks if connection is established
if ($conn->connect_error) {
        die("connection failed: " . $conn->connect_error);
} else {
        echo "connected to mysql";
        echo "<br>";
}


if ($result = $conn->query($sql)) {
        while ($data = $result->fetch_object()) {
                $users[] = $data;
        }
}

#lists all entries in the table (must have entries in db "rta-db" inside table "user")
foreach ($users as $user) {
        echo "<br>";
        echo "name, password";
        echo "<br>";
        echo $user->user_name . "," . $user->user_password;
        echo "<br>";
}


?>