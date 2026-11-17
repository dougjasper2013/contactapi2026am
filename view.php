<?php
    require ('connect.php');
    header('Content-Type: application/json');

    // Helpful for debugging
    ini_set('display_errors', 1);
    error_reporting(E_ALL);

    $contactID = isset($_GET['contactID']) ? (int) $_GET['contactID'] : 0;

    if ($contactID <= 0) {
        http_response_code(400);
        exit;
    }

    $sql = "SELECT * FROM `contacts` WHERE `contactID` = '{$contactID}' LIMIT 1";

    if ($result = mysqli_query($con, $sql))
    {
        if (mysqli_num_rows($result) == 1) {
            echo json_encode(mysqli_fetch_assoc($result));
        }
    }
    else
    {
        http_response_code(500);
    }

?>