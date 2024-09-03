<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Login</title>
    <style>
        body, html {
            margin: 0;
            padding: 0;
            font-family: 'Arial', sans-serif;
        }
        header {
            background-color: #343a40;
            padding: 10px 0;
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
            max-width: 360px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .container h1 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }
        .input-group label {
            display: block;
            margin-bottom: 10px;
            color: #555;
        }
        .input-group input {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        button[type="submit"]:hover {
            background-color: #0056b3;
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
                <li><a href="http://localhost:8080/hostel/home.jsp">Home</a></li>
                <li><a href="http://localhost:8080/hostel/about.jsp">About Project</a></li>
                <li><a href="http://localhost:8080/hostel/adminlogin.jsp">Admin Login</a></li>
                <li><a href="#" class="active">Student Login</a></li>
            </ul>
        </nav>
    </header>

    <div class="container">
        <h1>Student Login</h1>
        <form id="student-login-form" method="post">
            <div class="input-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="input-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <button type="submit">Login</button>
        </form>
        
    </div>

    <%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    if (username != null && password != null) {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        try {
            String jdbcUrl = "jdbc:mysql://localhost:3306/wt";
            String dbUsername = "root";
            String dbPassword = "";
            String jdbcDriver = "com.mysql.cj.jdbc.Driver";
            Class.forName(jdbcDriver);
            connection = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);
            String sql = "SELECT * FROM student WHERE username = ? AND password = ?";
            statement = connection.prepareStatement(sql);
            statement.setString(1, username);
            statement.setString(2, password);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                    int reg = resultSet.getInt("reg");
                    Cookie regCookie = new Cookie("studentReg", Integer.toString(reg));
                    regCookie.setMaxAge(60*60*24); 
                    response.addCookie(regCookie);
                    response.sendRedirect("student/profile.jsp");
                } else {
                    out.println("<p>Invalid credentials!</p>");
                }
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            } finally {
                if (resultSet != null) try { resultSet.close(); } catch (SQLException e) {  }
                if (statement != null) try { statement.close(); } catch (SQLException e) {  }
                if (connection != null) try { connection.close(); } catch (SQLException e) {  }
            }
        }
    %>
    <footer>
        <p>© 2023 Hostel Management System. All rights reserved.</p>
    </footer>
</body>
</html>