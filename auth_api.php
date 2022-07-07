<?php
if ( isset($_GET['delog']) ) :
    session_start();
    unset($_SESSION['user']);
    unset($_SESSION['token']);
    unset($_SESSION['expiration']);
    $response['response'] = "déconnection";
    $response['time'] = date('Y-m-d,H:i:s');
    $response['code'] = 200;
    echo json_encode($response);
    exit;
endif;

//connexion
require 'config.php';

    $json = file_get_contents('php://input');
    $arrayPOST = json_decode($json, true);
    if ( !isset($arrayPOST['login']) OR !isset($arrayPOST['password'])) :
        $response['message'] = "Il manque login et/ou password";
        $response['code'] = 500;    
    else :
    $sql = sprintf("SELECT * FROM users WHERE login = '%s' AND password = '%s'",
        $arrayPOST['login'],
        $arrayPOST['password']    
    );
    $result = $connect->query($sql);
    echo $connect->error;
    //test si les data sont justes
    if( $result->num_rows > 0 ) :
        $user = $result -> fetch_assoc();
        session_start();
        $_SESSION['user'] = $user['id_users'];
        $_SESSION['token'] = md5($user['login'].time());
        $_SESSION['expiration'] = time() + 1 * 600;
        $response['response'] = "OK connecté";
        $response['token'] = $_SESSION['token'];
        //$response['expiration'] = $_SESSION['expiration'];
        //myPrint_r($_SESSION);
    else:
        $response['response'] = "Erreur de log et/ou de mot de passe";
        $response['code'] = 403;
    endif;
endif;

$response['code'] = ( isset($response['code']) ) ? $response['code'] : 200;

$response['time'] = date('Y-m-d,H:i:s');

echo json_encode($response);
?>