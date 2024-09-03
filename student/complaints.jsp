<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>File a Complaint</title>
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
            max-width: 1000px;
            margin: 50px auto;
            padding: 0 20px;
        }
        .complaint-form {
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .complaint-form label {
            display: block;
            margin-bottom: 10px;
            color: #555;
        }
        .complaint-form input[type="text"], .complaint-form textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .complaint-form button[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .complaint-form button[type="submit"]:hover {
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
                <li><a href="http://localhost:8080/hostel/student/fetchnotice.jsp">Notices</a></li>
                <li><a href="#" class="active">Complaints</a></li>
                <li><a href="http://localhost:8080/hostel/student/payment.jsp">Payments</a></li>
                <li><a href="http://localhost:8080/hostel/student/profile.jsp">Profile</a></li>
            </ul>
        </nav>
    </header>
    <div class="container">
        <div class="complaint-form">
            <h2>File a Complaint</h2>
            <form action="complaints.jsp" method="post">
                <label for="title">Title:</label>
                <input type="text" id="title" name="title" required><br>
                <label for="description">Description:</label>
                <textarea id="description" name="description"></textarea><br>
                <button type="submit">Submit</button>
            </form>
        </div>
    </div>
    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String title = request.getParameter("title");
            String description = request.getParameter("description");

            // Debugging output
            out.println("<p>Title: " + title + "</p>");
            out.println("<p>Description: " + description + "</p>");

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con =DriverManager.getConnection("jdbc:mysql://localhost:3306/wt", "root", "");
                if (con != null) {
                    out.println("<p>Database connection is successful</p>");
                } else {
                    out.println("<p>Database connection failed</p>");
                }
                String sql = "INSERT INTO comp (title, description, created_at) VALUES (?, ?, NOW())";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, title);
                ps.setString(2, description);
                int result = ps.executeUpdate();
                if (result > 0) {
                    out.println("<p>Complaint sent successfully!</p>");
                } else {
                    out.println("<p>Failed to insert data</p>");
                }
                ps.close();
                con.close();
            } catch (Exception e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            }
        }
    %>
    <footer>
        <p>© 2024 Hostel Management System. All rights reserved.</p>
    </footer>
</body>
</html>