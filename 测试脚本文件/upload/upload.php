<?php
	header("Content-type: application/json; charset=utf-8");
    
	$uploaddir = 'file/';                                                   // 配置文件需要上传到服务器的路径，需要允许所有用户有可写权限，否则无法上传！
	
    $uploadfile = $uploaddir . basename($_FILES['userfile']['name']);
    
    move_uploaded_file($_FILES['userfile']['tmp_name'], $uploadfile);
    
    $result = array($_FILES, $_POST['username']);
    
    echo json_encode ($result);
?>
