<?php
  //simply get all the types of nodes
$types=node_type_get_types();
$type_names = array();

//variables to hold the output message
$types_report = "";
$types_counts = "";
$totalcontent = 0;

foreach($types as $type => $type_info){

  $ent_query = new EntityFieldQuery();
  $ent_query->entityCondition('entity_type','node')
    ->entityCondition('bundle',$type);

  $result = $ent_query->execute();

  $types_counts .= $type."   (".count($result['node']).")\n";

  $totalcontent += count($result['node']);
}

//print everthing out

echo $GLOBALS['base_url'] . " , " . strval($totalcontent). " \n";
