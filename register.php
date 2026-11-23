<?php
    require ('connect.php');
    header('Content-Type: application/json');

    // Helpful for debugging
    ini_set('display_errors', 1);
    error_reporting(E_ALL);

    // Get the posted data
    $postdata = json_decode(file_get_contents("php://input"));

    if (!isset($postdata->userName, $postdata->password, $postdata->emailAddress))
    {
        echo json_encode(['success' => false, 'message' => 'Missing required fields.']);
        exit;
    }

    $userName = trim($postdata->userName);
    $password = trim($postdata->password);
    $emailAddress = trim($postdata->emailAddress);

    // Check if userName or emailAddress already exists
    $check = $con->prepare("SELECT * FROM registrations WHERE userName = ? OR emailAddress = ?");
    $check->bind_param("ss", $userName, $emailAddress);
    $check->execute();
    $result = $check->get_result();

    if ($result->num_rows > 0) {
        echo json_encode(['success' => false, 'message' => 'Username or email already exists.']);
        exit;
    }

    // Hash the password
    $hashedPassword = password_hash($password, PASSWORD_DEFAULT);

    $insert = $con->prepare("INSERT INTO registrations (userName, password, emailAddress) VALUES (?, ?, ?)");
    $insert->bind_param("sss", $userName, $hashedPassword, $emailAddress);

    if ($insert->execute()) {
        echo json_encode(['success' => true, 'message' => 'User registered successfully.']);
    }
    else {
        echo json_encode(['success' => false, 'message' => 'Error during registration.']);
    }

?>