<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*, javax.servlet.http.Part"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notices</title>
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
            max-width: 800px;
            margin: 0px auto;
            padding: 0 20px;
        }

        .notice {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 20px;
        }

        .notice h2 {
            color: #007bff;
            margin-top: 0;
        }

        .notice p {
            margin: 10px 0;
        }

        .notice .timestamp {
            font-size: 12px;
            color: #777;
            text-align: right;
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
        h1 {
            text-align: center;
            margin-top: 8%;
        }
    </style>
</head>
<body>
    <header>
        <nav>
            <ul>
                <li><a href="http://localhost:8080/hostel/admin/fetchstudents.jsp">Student Data</a></li>
                <li><a href="http://localhost:8080/hostel/admin/addstudent.jsp">Add Student</a></li>
                <li><a href="http://localhost:8080/hostel/admin/rooms.jsp">Manage Rooms</a></li>
                <li><a href="#"class="active">Complaints</a></li>
                <li><a href="http://localhost:8080/hostel/admin/fetchpayments.jsp">Payments</a></li>
                <li><a href="http://localhost:8080/hostel/admin/notice.jsp">Notice</a></li>
            </ul>
        </nav>
    </header>

    <h1>View Complaints</h1>

    <div class="container">
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/wt", "root", "");
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM comp ORDER BY id DESC");

                while (rs.next()) {
        %>
                    <div class="notice">
                        <h2><%= rs.getString("title") %></h2>
                        <p><%= rs.getString("description") %></p>
                        <p class="timestamp">Posted on: <%= rs.getTimestamp("created_at") %></p>
                    </div>
        <%
                }
                rs.close();
                stmt.close();
                con.close();
            } catch (Exception e) {
                out.println("Error fetching notices: " + e.getMessage());
            }
        %>
    </div>
    
    <footer>
        <p>© 2024 Hostel Management System. All rights reserved.</p>
    </footer>
</body>
</html>
