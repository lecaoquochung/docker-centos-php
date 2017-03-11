<?php
    // https://www.diendannhatban.info/index.php?topic=3023
    // getenv('MYSQL_DATABASE');
    $host = getenv('DOCKERCENTOS6PHP_MYSQL_1_PORT_3306_TCP_ADDR');
    $username = getenv('MYSQL_USER');
    $password = getenv('MYSQL_PASSWORD');

    // Create connection
    $conn = mysqli_connect($host, $username, $password);

    // Check connection
    if (!$conn) {
        die("Connection failed: " . mysqli_connect_error());
    }
    echo "Connected successfully";
?>