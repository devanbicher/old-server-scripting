<?php
  //simply get all the types of nodes
$types=node_type_get_types();
$type_names = array();

echo "------- All content types -------\n";
foreach($types as $type => $type_info){
  echo $type."\n";
}

echo "------- Detailed Content Type Information \n";

foreach($types as $type => $type_info){
  //echo $type."\n";

  $ent_query = new EntityFieldQuery();
  $ent_query->entityCondition('entity_type','node')
    ->entityCondition('bundle',$type);

  $result = $ent_query->execute();

  echo $type."   (".count($result['node']).")\n";
  echo "____________\n";
  
  //  var_dump($result);
    //echo count($result);
  
  $fields_info = field_info_instances('node',$type);
  foreach($fields_info as $field => $fdata){
    echo $fdata['label']."  :  ".$field."\n";
    echo "    Widget:  ".$fdata['widget']['type']."  Module:  ".$fdata['widget']['module']."\n";
    
    if($fdata['display']['default']['type'] == 'hidden'){
      echo "HIDDEN \n";
	}
    
    if($fdata['required'] == 1){
      echo "REQUIRED \n";
    }
    
    if ($fdata['widget']['module'] == 'date'){
      var_dump($fdata);
    }

    echo "\n";
  }

  //var_dump($fdata);
  echo "\n----------------------\n\n";
}