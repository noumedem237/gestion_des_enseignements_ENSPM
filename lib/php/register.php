<?php
    include "connection.php";

    $nomDelegue = $_POST['nomDelegue'];
    $matriculeDelegue = $_POST['matriculeDelegue'];
    $emailDelegue = $_POST['emailDelegue'];
    $passwordDelegue = sha1($_POST['passwordDelegue']);
    $niveauDelegue = $_POST['niveauDelegue'];
    $cycleDelegue = $_POST['cycleDelegue'];
    $filiereDelegue = $_POST['filiereDelegue'];
    $optionDelegue = $_POST['optionDelegue'];
    $departement = $_POST['departement'];

    try {
       if(isset($nomDelegue, $matriculeDelegue, $emailDelegue, $passwordDelegue, $niveauDelegue, $cycleDelegue, $filiereDelegue, $optionDelegue, $departement)){
           $req = $db->prepare("SELECT * FROM delegue WHERE emailDelegue=?");        //
           $req->execute(array($emailDelegue));                                    //
           $exist = $req->rowCount();                                       //
           if($exist == 0){
               $req = $db->prepare("INSERT INTO delegue VALUES(null,?,?,?,?,?,?,?,?,?)");
                $req->execute(array($nomDelegue, $matriculeDelegue, $emailDelegue, $passwordDelegue, $niveauDelegue, $cycleDelegue, $filiereDelegue, $optionDelegue, $departement));                 //
                if($req){
                    $succes = 1;
                    $msg = "succes register";
                    $recup = $db->prepare("SELECT idDelegue FROM delegue WHERE emailDelegue=? ");
                    $recup->execute(array($emailDelegue));
                    $getid =$recup->fetch();
                    $donnes=$getid['idDelegue'];
               }else{
                   $succes = 0;
                   $msg = "error register";
               }
           }else{
              $msg = "email arealy exist";
              $succes = 0;
           }
       }else{
         $succes = 0;
         $msg = "error empty data";
       }
    } catch (\Throwable $th) {
      $succes = 0;
      $msg = "Error: ".$th->getMessage();
   }

    echo json_encode([
        "data"=>[
            $msg,
            $succes,
            $donnes
        ]
    ]);
?>