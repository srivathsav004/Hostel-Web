<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Data</title>
    <style>

        .search-box {
            padding: 0px;
            text-align: center;
        }

        .search-box input[type="text"] {
            padding: 10px;
            margin-top: 0px;
            width: 300px;
            font-size: 16px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #ddf;
        }

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
        button.logout-btn {
            background-color: #194e8f;
            color: #fff;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        button.logout-btn:hover {
            background-color: #c2c2c2;
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
<script>
    function fetchStudentData() {
        var regNumber = document.getElementById('regNumber').value;
        if (regNumber.length > 0) { 
            var xhr = new XMLHttpRequest();
            xhr.open('GET', 'fetchstudents.jsp?reg=' + regNumber, true);
            xhr.onload = function() {
                if (this.status == 200) {
                    document.getElementById('studentData').innerHTML = this.responseText;
                }
            };
            xhr.send();
        }
    }
</script>
<body>
    <header>
        <nav>
            <ul>
                <li><a href="#" class="active">Student Data</a></li>
                <li><a href="http://localhost:8080/hostel/admin/addstudent.jsp">Add Student</a></li>
                <li><a href="http://localhost:8080/hostel/admin/rooms.jsp">Manage Rooms</a></li>
                <li><a href="http://localhost:8080/hostel/admin/fetchcomplaints.jsp">Complaints</a></li>
                <li><a href="http://localhost:8080/hostel/admin/notice.jsp">Notice</a></li>
                <li><a href="http://localhost:8080/hostel/admin/fetchpayments.jsp">Payments</a></li>
                <li><a href="?logout=true">Logout</a></li>
            </ul>
        </nav>
    </header>

    <%
        String logout = request.getParameter("logout");
        if ("true".equals(logout)) {
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect("../adminlogin.jsp");
            return; 
        }
    %>

    <div class="search-box">
        <h1>Student Data</h1>
        <input type="text" id="regNumber" placeholder="Enter Registration Number" oninput="fetchStudentData()">
        <div id="studentData">
            <table>
                <tr>
                    <th>Name</th>
                    <th>Registration Number</th>
                    <th>Email</th>
                    <th>Department</th>
                    <th>Year</th>
                    <th>Course</th>
                    <th>Room Number</th>
                </tr>
                <%
                    String reg = request.getParameter("reg");
                    if (reg != null && !reg.isEmpty()) {
                        try {
                            String jdbcUrl = "jdbc:mysql://localhost:3306/wt";
                            String username = "root";
                            String password = "";
                            String jdbcDriver = "com.mysql.cj.jdbc.Driver";
                            Class.forName(jdbcDriver);
                            Connection connection = DriverManager.getConnection(jdbcUrl, username, password);
                            String sql = "SELECT * FROM student WHERE reg = ?";
                            PreparedStatement statement = connection.prepareStatement(sql);
                            statement.setInt(1, Integer.parseInt(reg));
                            ResultSet resultSet = statement.executeQuery();
                            while (resultSet.next()) {
                %>
                <tr>
                    <td><%= resultSet.getString("student_name") %></td>
                    <td><%= resultSet.getInt("reg") %></td>
                    <td><%= resultSet.getString("email") %></td>
                    <td><%= resultSet.getString("dept") %></td>
                    <td><%= resultSet.getInt("year") %></td>
                    <td><%= resultSet.getString("course") %></td>
                    <td><%= resultSet.getInt("room_number") %></td>
                </tr>
                <%
                            }
                            resultSet.close();
                            statement.close();
                            connection.close();
                        } catch (Exception e) {
                            out.println("Error: " + e.getMessage());
                        }
                    }
                %>
            </table>
        </div>
    </div>

         <div class="container">
             <h1>All Student Data</h1>
             <table>
                 <tr>
                     <th>Name</th>
                     <th>Registration Number</th>
                     <th>Email</th>
                     <th>Department</th>
                     <th>Year</th>
                     <th>Course</th>
                     <th>Room Number</th>
                 </tr>
                 <%
                     String jdbcUrl = "jdbc:mysql://localhost:3306/wt";
                     String username = "root";
                     String password = "";
                     String jdbcDriver = "com.mysql.jdbc.Driver";
                     Connection connection = null;
                     Statement statement = null;
                     ResultSet resultSet = null;
                     try {
                         Class.forName(jdbcDriver);
                         connection = DriverManager.getConnection(jdbcUrl, username, password);
                         statement = connection.createStatement();
                         String sql = "SELECT * FROM student";
                         resultSet = statement.executeQuery(sql);
                         while (resultSet.next()) {
                 %>
                 <tr>
                     <td><%= resultSet.getString("student_name") %></td>
                     <td><%= resultSet.getInt("reg") %></td>
                     <td><%= resultSet.getString("email") %></td>
                     <td><%= resultSet.getString("dept") %></td>
                     <td><%= resultSet.getInt("year") %></td>
                     <td><%= resultSet.getString("course") %></td>
                     <td><%= resultSet.getInt("room_number") %></td>
                 </tr>
                 <%
                         }
                     } catch (Exception e) {
                         out.println("Error: " + e.getMessage());
                     } finally {
                         if (resultSet != null) try { resultSet.close(); } catch (SQLException e) { e.printStackTrace(); }
                         if (statement != null) try { statement.close(); } catch (SQLException e) { e.printStackTrace(); }
                         if (connection != null) try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
                     }
                 %>
             </table>
         </div>
     
         <footer>
        <p>© 2024 Hostel Management System. All rights reserved.</p>
    </footer>
     </body>
     </html>