<?php
// Credentials from docker-compose.yml
$host = 'mariadb';
$user = 'rta-dbuser';
$pass = '123456';
$mydatabase = 'rta-db';
$mytable = 'name';

// Create a connection
$conn = new mysqli($host, $user, $pass, $mydatabase);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Initialize variables
$name = "";
$message = "";

// Process form submission
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST["submit"])) {
    $name = $_POST["name"];

    // SQL INSERT query
    $sql = "INSERT INTO $mytable (name) VALUES ('$name')";

    if ($conn->query($sql) === TRUE) {
        $message = "Record inserted successfully.";
        // Clear the input value after successful insertion
        $name = "";

        // Redirect to prevent form resubmission
        header("Location: " . $_SERVER['PHP_SELF'] . "?success=1");
        exit();

    } else {
        $message = "Error: " . $sql . "<br>" . $conn->error;
    }
}

// Display success message if redirected with success parameter
if (isset($_GET["success"]) && $_GET["success"] == 1) {
        $message = "Record inserted successfully.";
        // Refresh the page after a delay
        echo '<meta http-equiv="refresh" content="5;url=' . $_SERVER['PHP_SELF'] . '">';
    }

// Close the connection
$conn->close();
?>

<!DOCTYPE html>
<html>
<head>
    <title>php into sql</title>
    <link rel="stylesheet" type="text/css" href="style2.css">
</head>
<body>
    <div class="container">
        <h1>sql test</h1>
        
        <form method="post" action="">
            <label for="name">Enter your name:</label>
            <input type="text" id="name" name="name" value="<?php echo $name; ?>" required>
            <input type="submit" name="submit" value="Submit">
        </form>
        
        <?php echo "<p>$message</p>"; ?>
       
    </div>
</body>
</html>
