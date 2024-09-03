<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*, javax.servlet.http.Part"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Send Notice</title>
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
            padding-top: 100px; /* Adjust for fixed header */
            max-width: 600px;
            margin: 0 auto;
        }

        h2 {
            text-align: center;
            color: #007bff;
            margin-bottom: 20px;
        }

        label {
            font-weight: bold;
        }

        input[type="text"],
        textarea,
        input[type="file"],
        button[type="submit"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        button[type="submit"] {
            background-color: #007bff;
            color: #fff;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
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
                <li><a href="http://localhost:8080/hostel/admin/fetchstudents.jsp">Student Data</a></li>
                <li><a href="http://localhost:8080/hostel/admin/addstudent.jsp">Add Student</a></li>
                <li><a href="http://localhost:8080/hostel/admin/rooms.jsp">Manage Rooms</a></li>
                <li><a href="http://localhost:8080/hostel/admin/fetchcomplaints.jsp">Complaints</a></li>
                <li><a href="http://localhost:8080/hostel/admin/fetchpayments.jsp">Payments</a></li>
                <li><a href="#" class="active">Notice</a></li>
            </ul>
        </nav>
    </header>

    <div class="container">
        <h2>Send Notice</h2>
        <form action="notice.jsp" method="post" >
            <label for="title">Title:</label>
            <input type="text" id="title" name="title" required><br>
            <label for="description">Description:</label>
            <textarea id="description" name="description"></textarea><br>
            <button type="submit">Send</button>
        </form>
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
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/wt", "root", "");
                if (con != null) {
                    out.println("<p>Database connection is successful</p>");
                } else {
                    out.println("<p>Database connection failed</p>");
                }
                String sql = "INSERT INTO notices (title, description, created_at) VALUES (?, ?, NOW())";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, title);
                ps.setString(2, description);
                int result = ps.executeUpdate();
                if (result > 0) {
                    out.println("<p>Notice sent successfully!</p>");
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
