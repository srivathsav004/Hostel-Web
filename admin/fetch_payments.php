<?php
$conn = new mysqli("localhost", "root", "", "wt");
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
$query = "SELECT * FROM payments";
$result = $conn->query($query);

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        echo "Name: " . $row["student_name"] . " - Reg. Number: " . $row["reg"] . " - File: <a href='uploads/" . $row["file_name"] . "'>" . $row["file_name"] . "</a><br>";
    }
} else {
    echo "No payments found.";
}
$conn->close();
?>