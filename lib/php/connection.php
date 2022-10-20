<?php
    $host = "localhost";
    $dbname = "id17365222_database_epharmacie";
    $user = "id17365222_name_user_db";
    $pass = "1+H\9/~5d>^cTq7_#";

    try {
        $db = new PDO("mysql:host=$host; dbname=$dbname", $user, $pass);
        // echo "connected";
    } catch (\Throwable $th) {
        // echo "Error: ".$th->getMessage();
    }
?>



