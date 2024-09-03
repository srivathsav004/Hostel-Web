<?php
$targetDir = "uploads/";
$fileName = basename($_FILES["fileUpload"]["student_name"]);
$targetFilePath = $targetDir . $fileName;
$fileType = pathinfo($targetFilePath, PATHINFO_EXTENSION);

$allowTypes = array('jpg', 'png', 'jpeg', 'pdf');
if (in_array($fileType, $allowTypes)) {
    if (move_uploaded_file($_FILES["fileUpload"]["tmp_name"], $targetFilePath)) {
        $conn = new mysqli("localhost", "root", "", "wt");
        if ($conn->connect_error) {
            die("Connection failed: " . $conn->connect_error);
        }
        $stmt = $conn->prepare("INSERT INTO payments (name, reg, dept, year, file_name) VALUES (?, ?, ?, ?, ?, ?)");
        if ($stmt) {
            $stmt->bind_param("ssssss", $_POST['student_name'], $_POST['reg'], $_POST['dept'],  $_POST['year'], $fileName);
            $stmt->execute();
            echo "The file " . $fileName . " has been uploaded successfully.";
            $stmt->close();
        } else {
            echo "Error preparing statement: " . $conn->error;
        }
        $conn->close();
    } else {
        echo "Sorry, there was an error uploading your file.";
    }
} else {
    echo "Sorry, only JPG, JPEG, PNG, & PDF files are allowed to upload.";
}
?>