<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*, javax.servlet.http.Part"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payments</title>
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

        .container {
            padding-top: 20px; 
            padding-bottom: 60px; 
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
        }

        .payment {
            background-color: #ffffff;
            padding: 20px;
            margin: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            max-width: 300px;
            width: 100%;
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
                <li><a href="#">Complaints</a></li>
                <li><a href="#" class="active">Payments</a></li>
                <li><a href="http://localhost:8080/hostel/admin/notice.jsp">Notice</a></li>
            </ul>
        </nav>
    </header>

    <h1>View Submitted Payments</h1>

    <div class="container">
        <% 
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            try {
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/wt", "root", "");
                pstmt = conn.prepareStatement("SELECT * FROM payments");
                rs = pstmt.executeQuery();
                while (rs.next()) {
        %>
        <div class="payment">
            <p><strong>Name:</strong> <%= rs.getString("name") %></p>
            <p><strong>Registration Number:</strong> <%= rs.getString("reg_number") %></p>
            <a href="http://localhost/hostel/uploads/<%= rs.getString("file_name") %>" target="_blank"><%= rs.getString("file_name") %></a>
        </div>
        <% 
                }
            } catch (SQLException se) {
                se.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { }
                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { }
                if (conn != null) try { conn.close(); } catch (SQLException e) { }
            }
        %>
    </div>
    
    <footer>
        <p>© 2024 Hostel Management System. All rights reserved.</p>
    </footer>
</body>
</html>
