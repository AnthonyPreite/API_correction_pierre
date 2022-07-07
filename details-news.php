<?php 
include 'config.php';
include 'headers.php';

require "verif_auth.php";


//myPrint_r($_GET);
if ($_SERVER['REQUEST_METHOD'] == 'GET') :
    $sql = "SELECT * FROM news WHERE id = " . $_GET['id_news'];
    $result = $connect->query($sql);
    echo $connect-> error;
    if($result->num_rows > 0) :
        $response['data'] = $result->fetch_all(MYSQLI_ASSOC);
        $response['response'] = "One news " . $_GET['id_news'];
    else :
        $response['response'] = "contenu non disponible";
        $response['code'] = 404;
    endif;
endif; // GET ?

if ($_SERVER['REQUEST_METHOD'] == 'DELETE') :
    $sql = sprintf("DELETE FROM news WHERE id = %d",
        $_GET['id_news']
    );
    $connect->query($sql);
    echo $connect->error;
    $response['response'] = "Suppression news id {$_GET['id_news']}";
endif; //DELETE ?

if ($_SERVER['REQUEST_METHOD'] == 'PUT') :
    $json = file_get_contents('php://input');
    $arrayJSON = json_decode($json, true);
    $sql = sprintf("UPDATE news SET titre='%s', contenu='%s' WHERE id = %d",
        strip_tags(addslashes($arrayJSON['titre'])),
        strip_tags(addslashes($arrayJSON['contenu'])),
        $_GET['id_news']
    );
    $result = $connect->query($sql);
    echo $connect->error;

    $response['new_data'] = $arrayJSON;
    $response['response'] = 'edit news id ' . $_GET['id_news'];
endif;

$response['code'] = (isset($response['code'])) ? $response['code'] : 200;
echo json_encode($response);
exit;
?>