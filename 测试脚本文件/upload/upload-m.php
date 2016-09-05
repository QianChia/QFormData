<?php
    header("Content-type: application/json; charset=utf-8");
    
	$uploaddir = 'file/';                                                       // 配置文件需要上传到服务器的路径，需要允许所有用户有可写权限，否则无法上传！
    
    for ($i = 0; $i < count($_FILES['userfile']['tmp_name']); $i++) {
        
        $upfile = $uploaddir . $_FILES['userfile']['name'][$i];
        
        move_uploaded_file($_FILES['userfile']['tmp_name'][$i], $upfile);
    }
    
    $result = array($_FILES, $_POST['username']);
    
    echo json_encode ($result);
?>
