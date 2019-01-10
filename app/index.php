<?php
error_reporting(-1);
ini_set('display_errors', 'On');
try {

    $mng = new MongoDB\Driver\Manager("mongodb://root:example@mongo");

    $stats = new MongoDB\Driver\Command(["dbstats" => 1]);
    $res = $mng->executeCommand("car", $stats);
    
    $stats = current($res->toArray());
    echo '<pre>';
    print_r($stats);
    echo '</pre>';

} catch (MongoDB\Driver\Exception\Exception $e) {

    $filename = basename(__FILE__);
    
    echo "The $filename script has experienced an error.\n"; 
    echo "It failed with the following exception:\n";
    
    echo "Exception:", $e->getMessage(), "\n";
    echo "In file:", $e->getFile(), "\n";
    echo "On line:", $e->getLine(), "\n";       
}