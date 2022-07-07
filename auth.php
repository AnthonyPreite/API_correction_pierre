<?php
if ( isset($_GET['delog']) ) :
    session_start();
    unset($_SESSION['user']);
    unset($_SESSION['token']);
    header("location:auth.php");
    exit;
endif;
require 'config.php';
if( isset($_POST['ident'])) :
    $sql = sprintf("SELECT * FROM users WHERE login = '%s' AND password = '%s'",
        $_POST['login'],
        $_POST['password']    
    );
    $result = $connect->query($sql);
    echo $connect->error;
    //test si les data sont justes
    if( $result->num_rows > 0 ) :
        $user = $result -> fetch_assoc();
        session_start();
        $_SESSION['user'] = $user['id_users'];
        $_SESSION['token'] = md5($user['login'].time());
        header("location:secure.php");
        exit;
        //myPrint_r($_SESSION);
    else:
        echo 'erreur de log et pass';
    endif;
endif;
?>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Qui suis-je ?</title>
</head>
<body>
    <form action="" method="post">
        <input type="text" name="login" placeholder="Votre login">
        <input type="password" name="password" placeholder="Votre mot de passe">
        <input type="hidden" name="ident">
        <button>S'identifier</button>
    </form>
</body>
</html>