<?php
include 'config.php';
include 'headers.php';
require "verif_auth.php";


//recup d'une ou plusieurs catégories
if ($_SERVER['REQUEST_METHOD'] == 'GET') :
    //recup d'une catégorie
    if( isset($_GET['id_categories'])) :
        $sql = sprintf("SELECT * FROM categories WHERE id = %d",
            $_GET['id_categories']
        );
        $response['response'] = 'One cat with id '.$_GET['id_categories'].' et ses produits';
        //recup des produits de la catégorie
        $sql_produits = sprintf("SELECT * FROM produits WHERE id_categories = %d",$_GET['id_categories'] );
        $result_produits = $connect->query($sql_produits);
        //si il y a des produits, on crée une entrée 'produits' dans $response
        if($result_produits->num_rows > 0):
            $response["produits"]["data"] = $result_produits->fetch_all(MYSQLI_ASSOC);
            $response["produits"]["nb_hits"] = $result_produits->num_rows;
        else:
            //si pas de produit, nb_hits des produits = 0
            $response['produits']["nb_hits"] = 0;
        endif;
    else :
        //recup des catégories seules
        $sql = "SELECT * FROM categories ORDER BY label ASC";
        $response['response'] = 'All categories';
    endif;

    $result = $connect->query($sql);
    echo $connect->error;

    $response['data'] = $result->fetch_all(MYSQLI_ASSOC);
    $response['nb_hits'] = $result->num_rows;
endif; //end GET

//surppresion d'une catégorie
if ($_SERVER['REQUEST_METHOD'] == 'DELETE') :
    //si on a l'id de la catégorie 
    if( isset($_GET['id_categories']) ) :
    //test si il y a des produits. Si oui on ne peut la supprimer
    $sql = sprintf("SELECT * FROM produits WHERE id_categories=%d",
        $_GET['id_categories']
    );
    $result = $connect->query($sql);
    //si la catégorie n'a pas de produit
    if($result->num_rows == 0):
        $sql = sprintf("DELETE FROM categories WHERE id=%d",
            $_GET['id_categories']
        );
        $connect->query($sql);
        echo $connect->error;
        $response['response'] = "Delete categories id {$_GET['id_categories']}";
    else :
    //si la catégorie a des produits
        $response['response'] = "Vous devez supprimer d'abord les produits";
        $response['code'] = 500;
    endif;
    else :
        //si on n'a pas l'id de la catégorie
        $response['response'] = "Il manque l'id";
        $response['code'] = 500;
    endif;
    //exit;
endif;

//ajout d'une catégorie
if ($_SERVER['REQUEST_METHOD'] == 'POST') :
    //extraction de l'objet json du paquet HTTP
    $json = file_get_contents('php://input');
    //décodage du format json, ça génère un object PHP
    $objectPOST = json_decode($json);
    $sql = sprintf("INSERT INTO categories SET label='%s'",
        strip_tags(addslashes($objectPOST->label))
    );
    $connect->query($sql);
    echo $connect->error;
    $response['response'] = "Ajout une catégorie avec id " . $connect->insert_id;
    $response['new_id'] = $connect->insert_id;
       
    //exit;
endif; //END POST

//edition d'une catégorie

if ($_SERVER['REQUEST_METHOD'] == 'PUT') :
    //extraction de l'objet json du paquet HTTP
    $json = file_get_contents('php://input');
    //décodage du format json, ça génère un object PHP
    //$objectPOST = json_decode($json);
    $arrayPOST = json_decode($json, true);

    //si on a bien le nouveau label
    if( isset($arrayPOST['label'])) :
        $sql = sprintf("UPDATE categories SET label='%s' WHERE id= %d",
            strip_tags(addslashes($arrayPOST['label'])), //lire une propriété d'un objet PHP
            $_GET['id_categories']
        );
        $connect->query($sql);
        echo $connect->error;
        $response['response'] = "Edit une catégorie avec id " . $_GET['id_categories'];
        $response['new_data'] = $arrayPOST;
        unset($response['new_data']['token']);
    else :
        //si il manque le 'label"
        $response['response'] = "Il manque des données";
        $response['code'] = 500;
    endif;
endif; //END PUT

//generation du code 200 par défaut si le code n'est pas encore défini
$response['code'] = ( isset($response['code']) ) ? $response['code'] : 200;
//définition de la ate et heure de la requête
$response['time'] = date('Y-m-d,H:i:s');
//encodage en json et affichage
echo json_encode($response);