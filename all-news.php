<?php
include 'config.php';
include 'headers.php';

require "verif_auth.php";

if ($_SERVER['REQUEST_METHOD'] == 'GET') :
    $sql = "SELECT * FROM news";
    $result = $connect->query($sql);
    echo $connect->error;

    $response['data'] = $result->fetch_all(MYSQLI_ASSOC);
    $response['nb_hits'] = $result->num_rows;
    $response['response'] = 'All news';
endif;
if ($_SERVER['REQUEST_METHOD'] == 'POST') :
    $json = file_get_contents('php://input');
    $objectJSON = json_decode($json);
    $sql = sprintf("INSERT INTO news SET titre='%s', contenu='%s'",
        addslashes($objectJSON->titre),
        strip_tags(addslashes($objectJSON->contenu))
    );
    $result = $connect->query($sql);
    echo $connect->error;

    $response['new_id'] = $connect->insert_id;
    $response['response'] = 'new news';
endif;

$response['code'] = (isset($response['code'])) ? $response['code'] : 200;


echo json_encode($response);