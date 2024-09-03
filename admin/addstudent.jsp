<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Student Details</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
            color: #333;
        }

        header {
            background-color: #343a40;
            padding: 15px 0;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        nav ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            text-align: center;
        }

        nav ul li {
            display: inline;
        }

        nav ul li a {
            display: inline-block;
            padding: 10px 20px;
            text-decoration: none;
            color: #fff;
        }

        nav ul li a.active {
            background-color: #007bff;
            border-radius: 5px;
        }

        .container {
            margin-top: 20px;
            padding: 15px;
            text-align: center;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-wrap: wrap;
        }

        .container > div {
            margin: 10px;
        }

        .container input[type="text"],
        .container input[type="number"],
        .container input[type="email"],
        .container input[type="password"] {
            padding: 12px;
            margin: 10px;
            width: 300px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
            outline: none;
            transition: border-color 0.3s ease;
        }

        .container input[type="text"]:focus,
        .container input[type="number"]:focus,
        .container input[type="email"]:focus,
        .container input[type="password"]:focus {
            border-color: #007bff;
        }

        .container input[type="submit"] {
            padding: 12px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .container input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .error {
            color: red;
            margin-top: 10px;
        }

        footer {
            background-color: #343a40;
            color: #fff;
            text-align: center;
            padding: 15px 0;
            position: fixed;
            bottom: 0;
            width: 100%;
            box-shadow: 0 -2px 4px rgba(0, 0, 0, 0.1);
        }

        footer p {
            margin: 0;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <header>
        <nav>
            <ul>
                <li><a href="http://localhost:8080/hostel/admin/fetchstudents.jsp">Student Data</a></li>
                <li><a href="#" class="active" >Add Student</a></li>
                <li><a href="http://localhost:8080/hostel/admin/rooms.jsp">Manage Rooms</a></li>
                <li><a href="http://localhost:8080/hostel/admin/fetchcomplaints.jsp">Complaints</a></li>
                <li><a href="http://localhost:8080/hostel/admin/fetchpayments.jsp">Payments</a></li>
                <li><a href="http://localhost:8080/hostel/admin/notice.jsp">Notice</a></li>
            </ul>
        </nav>
    </header>

<div class="container">
    <div>
        <h1>Add Student Details</h1>
        <form action="" method="post" onsubmit="return validateForm()">
            <input type="text" id="name" name="name" placeholder="Student Name">
            <br>
            <input type="number" id="reg" name="reg" placeholder="Registration Number">
            <br>
            <input type="email" id="email" name="email" placeholder="Email">
            <br>
            <input type="text" id="dept" name="dept" placeholder="Department">
            <br>
            <input type="number" id="year" name="year" placeholder="Year">
            <br>
            <input type="text" id="course" name="course" placeholder="Course">
            <br>
            <input type="number" id="roomNumber" name="roomNumber" placeholder="Room Number">
    </div>
    <div>
        <input type="text" id="username" name="username" placeholder="Username">
        <br>
        <input type="password" id="password" name="password" placeholder="Password">
        <br>
        <input type="submit" value="Add Student">
    </form>
    <div id="errorMessage" class="error"></div>
    </div>
</div>

<footer>
    <p>© 2024 Hostel Management System. All rights reserved.</p>
</footer>

<%
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String name = request.getParameter("name");
        int reg = Integer.parseInt(request.getParameter("reg"));
        String email = request.getParameter("email");
        String dept = request.getParameter("dept");
        int year = Integer.parseInt(request.getParameter("year"));
        String course = request.getParameter("course");
        int roomNumber = Integer.parseInt(request.getParameter("roomNumber"));
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        String jdbcUrl = "jdbc:mysql://localhost:3306/wt";
        String dbUsername = "root";
        String dbPassword = "";
        String jdbcDriver = "com.mysql.jdbc.Driver";

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            Class.forName(jdbcDriver);
            connection = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);
            String query = "INSERT INTO student (student_name, reg, email, dept, year, course, room_number, username, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, name);
            preparedStatement.setInt(2, reg);
            preparedStatement.setString(3, email);
            preparedStatement.setString(4, dept);
            preparedStatement.setInt(5, year);
            preparedStatement.setString(6, course);
            preparedStatement.setInt(7, roomNumber);
            preparedStatement.setString(8, username);
            preparedStatement.setString(9, password);

            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) {
                out.println("<script>alert('Student added successfully!');</script>");
            } else {
                out.println("<script>alert('Failed to add student!');</script>");
            }
        } catch (Exception e) {
            out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
        } finally {
            if (preparedStatement != null) {
                try {
                    preparedStatement.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
%>
<script>
    function clearCacheAndReload() {
            location.reload(true);
        }
</script>

</body>
</html>
