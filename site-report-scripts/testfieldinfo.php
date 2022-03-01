<?php

$types=node_type_get_types();
$type_names = array();

foreach($types as $type => $type_info){
  echo $type."\n";
  //  var_dump($type_info->base);
  
  $fields_info = field_info_instances('node',$type);
  var_dump($fields_info);
  /*
  foreach ($fields_info as $field_name => $value) {
    $field_info = field_info_field($field_name);
    echo $field_name;
    var_dump($field_info);
  }
  */
}
?>