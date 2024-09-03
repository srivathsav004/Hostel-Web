<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*, javax.servlet.http.Cookie"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Profile</title>
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
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .welcome-message {
            text-align: center;
            margin: 20px 0;
            font-size: 24px;
            color: #333;
        }
        .profile-form label {
            display: block;
            margin-bottom: 10px;
            color: #555;
        }
        .profile-form input[type="text"],
        .profile-form input[type="email"],
        .profile-form input[type="number"] {
            width: calc(100% - 22px);
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
            transition: border-color 0.3s;
        }
        .profile-form button[type="submit"] {
            width: calc(100% - 22px);
            padding: 12px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .profile-form button[type="submit"]:hover {
            background-color: #0056b3;
        }
        .logout-button {
            display: inline-block;
            padding: 12px;
            background-color: #007bff;
            color: #fff;
            text-decoration: none;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .logout-button:hover {
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
                <li><a href="http://localhost:8080/hostel/student/complaints.jsp">Complaints</a></li>
                <li><a href="http://localhost:8080/hostel/student/payment.jsp">Payments</a></li>
                <li><a href="#" class="active">Profile</a></li>
            </ul>
        </nav>
    </header>
    
    
    <div class="container">
        <%
            String studentReg = null;
            String name = null;
            String email = null;
            String dept = null;
            int year = 0;
            String course = null;
            
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if ("studentReg".equals(cookie.getName())) {
                        studentReg = cookie.getValue();
                        break;
                    }
                }
            }

            if (studentReg == null) {
                response.sendRedirect("../studentlogin.jsp");
            } else {
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                try {
                    String jdbcUrl = "jdbc:mysql://localhost:3306/wt";
                    String dbUsername = "root";
                    String dbPassword = "";
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);
                    String sql = "SELECT * FROM student WHERE reg = ?";
                    ps = con.prepareStatement(sql);
                    ps.setInt(1, Integer.parseInt(studentReg));
                    rs = ps.executeQuery();
                    if (rs.next()) {
                        name = rs.getString("student_name");
                        email = rs.getString("email");
                        dept = rs.getString("dept");
                        year = rs.getInt("year");
                        course = rs.getString("course");

                        out.println("<div class='welcome-message'>Hi, " + name + "!</div>");
        %>
        <form class="profile-form" method="post">
            <label for="student_name">Name:</label>
            <input type="text" id="student_name" name="student_name" value="<%= name %>">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" value="<%= email %>">
            <label for="dept">Department:</label>
            <input type="text" id="dept" name="dept" value="<%= dept %>">
            <label for="year">Year:</label>
            <input type="number" id="year" name="year" value="<%= year %>">
            <label for="course">Course:</label>
            <input type="text" id="course" name="course" value="<%= course %>">
            <button type="submit">Update Profile</button>
        </form>
        <% 
                    }
                    if ("post".equalsIgnoreCase(request.getMethod())) {
                        // Update profile logic
                        name = request.getParameter("student_name");
                        email = request.getParameter("email");
                        dept = request.getParameter("dept");
                        year = Integer.parseInt(request.getParameter("year"));
                        course = request.getParameter("course");

                        sql = "UPDATE student SET student_name = ?, email = ?, dept = ?, year = ?, course = ? WHERE reg = ?";
                        ps = con.prepareStatement(sql);
                        ps.setString(1, name);
                        ps.setString(2, email);
                        ps.setString(3, dept);
                        ps.setInt(4, year);
                        ps.setString(5, course);
                        ps.setInt(6, Integer.parseInt(studentReg));
                        int updateCount = ps.executeUpdate();
                        if (updateCount > 0) {
                            out.println("<p>Profile updated successfully!</p>");
                        } else {
                            out.println("<p>Failed to update profile.</p>");
                        }
                    }
                } catch (Exception e) {
                    out.println("Error: " + e.getMessage());
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) { /* ignored */ }
                    if (con != null) try { con.close(); } catch (SQLException e) { /* ignored */ }
                }
            }
        %>
        <form class="logout-form" method="post">
            <input type="hidden" name="action" value="logout">
            <button type="submit">Logout</button>
        </form>
    </div>
    <footer>
        <p>© 2024 Hostel Management System. All rights reserved.</p>
    </footer>
</body>
</html>
               