<?php
    date_default_timezone_set('America/Toronto'); // For those on Eastern Timezone
    // date_default_timezone_set('America/Halifax'); // For those on Atlantic Timezone
    require('connect.php');
    header('Content-Type: application/json');
    // Helpful for debugging
    ini_set('display_errors', 1);
    error_reporting(E_ALL);

    // Get the posted data
    $postdata = json_decode(file_get_contents("php://input"));

    $userName = mysqli_real_escape_string($con, $postdata->userName ?? '');
    $password = $postdata->password ?? '';

    if (empty($userName) || empty($password)) {
        http_response_code(400);
        echo json_encode(['error' => 'userName and password are required.']);
        exit;
    }

    // Retrieve the user record
    $sql = "SELECT * FROM registrations WHERE userName = '$userName' LIMIT 1";
    $result = mysqli_query($con, $sql);

    if ($result && mysqli_num_rows($result) === 1) {
        $user = mysqli_fetch_assoc($result);

        $failedAttempts = (int)$user['failedAttempts'];
        $lastFailed = $user['lastFailedLogin'] ? strtotime($user['lastFailedLogin']) : 0;
        $lockoutDuration = 120; // 2 minutes in seconds
        
        // Check if account is locked
        if ($failedAttempts >= 3 && (time() - $lastFailed) < $lockoutDuration) {
            $remaining = ceil(($lockoutDuration - (time() - $lastFailed)) / 60);
            http_response_code(403);
            echo json_encode(['error' => "Account locked. Try aagin in $remaining minute(s)."]);
            exit;
        }

        // Verify password
        if (password_verify($password, $user['password'])) {
            // reset failed attempts on success
            $update = "UPDATE registrations SET failedAttempts = 0, lastFailedLogin = NULL WHERE userID = {$user['userID']}";
            mysqli_query($con, $update);
            http_response_code(200);
            echo json_encode(['success' => true, 'message' => 'Login successful.']);
            exit;
        }
        else {
            // increment failed attempts
            $failedAttempts++; // adds 1 to the value stored in $failedAttempts

            $update = "UPDATE registrations SET failedAttempts = $failedAttempts, lastFailedLogin = NOW() WHERE userID = {$user['userID']}";
            mysqli_query($con, $update);

            // Calculate remaining attempts before lockout
            $remainingAttempts = max(0, 3 - $failedAttempts);

            http_response_code(401);
            echo json_encode(['error' => 'Invalid userName or password',
            'remainingAttempts' => $remainingAttempts]);
            exit;
        }

    }
    else {
        http_response_code(404);
        echo json_encode(['error' => 'User not found']);
        exit;
    }

?>