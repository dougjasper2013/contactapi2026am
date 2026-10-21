<?php

    // db credentials
    define('DB_HOST', 'localhost');
    define('DB_USER', 'root');
    define('DB_PASS', '');
    define('DB_NAME', 'contact_manager_2026_am');

    // Connect with the database
    function connect()
    {
        $connect = mysqli_connect(DB_HOST, DB_USER, DB_PASS, DB_NAME);

        if (mysqli_connect_errno())
        {
            die("Failed to connect:" . mysql_connect_errno());
        }

        mysqli_set_charset($connect, "utf8");

        return $connect;
    }

    $con = connect();

?>