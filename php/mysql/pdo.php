<?php
    // https://www.diendannhatban.info/index.php?topic=3023
    $host = getenv('DOCKERCENTOS6PHP_MYSQL_1_PORT_3306_TCP_ADDR');
    $username = getenv('MYSQL_USER');
    $password = getenv('MYSQL_PASSWORD');
    $database = getenv('MYSQL_DATABASE');

    try {
        $conn = new PDO("mysql:host=$host;dbname=$database", $username, $password);
        // set the PDO error mode to exception
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        echo "Connected successfully"; 
    }
    
    catch(PDOException $e)
    {
        echo "Connection failed: " . $e->getMessage();
    }
?>