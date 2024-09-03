<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Rooms</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
            color: #333;
        }
        header, footer {
            background-color: #343a40;
            color: #fff;
            padding: 15px 0;
            position: fixed;
            width: 100%;
            z-index: 1000;
        }
        header {
            top: 0;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        footer {
            bottom: 0;
            box-shadow: 0 -2px 4px rgba(0, 0, 0, 0.1);
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
            padding-top: 100px; 
            padding-bottom: 60px; 
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
        }
        .room {
            background-color: #ffffff;
            padding: 20px;
            margin: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            max-width: 300px;
            width: 100%;
        }
        .update-form {
            margin-top: 10px;
        }
        .message-container {
            position: fixed;
            top: 100px;
            left: 0;
            right: 0;
            text-align: center;
            z-index: 1050; 
        }
        .message {
            display: inline-block;
            padding: 10px;
            border-radius: 5px;
            color: #fff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.3);
            margin: 10px auto;
        }
        .success {
            background-color: #28a745; /* Green for success */
        }
        .error {
            background-color: #dc3545; /* Red for error */
        }
    </style>
</head>
<body>
    <header>
        <nav>
            <ul>
                <li><a href="http://localhost:8080/hostel/admin/fetchstudents.jsp">Student Data</a></li>
                <li><a href="http://localhost:8080/hostel/admin/addstudent.jsp">Add Student</a></li>
                <li><a href="#" class="active">Manage Rooms</a></li>
                <li><a href="http://localhost:8080/hostel/admin/fetchcomplaints.jsp">Complaints</a></li>
                <li><a href="http://localhost:8080/hostel/admin/fetchpayments.jsp">Payments</a></li>
                <li><a href="http://localhost:8080/hostel/admin/notice.jsp">Notice</a></li>
            </ul>
        </nav>
    </header>

    <div class="container">
        <% 
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            String newRoomNumber = request.getParameter("newRoomNumber");
            String reg = request.getParameter("reg");
            boolean showMessage = false;
            String message = "";
            String messageType = "";

            try {
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/wt", "root", "");
                // Display all rooms with current data
                pstmt = conn.prepareStatement("SELECT * FROM student ORDER BY room_number ASC");
                rs = pstmt.executeQuery();
                while (rs.next()) {
                    out.println("<div class='room'>");
                    out.println("<h4>Room " + rs.getString("room_number") + "</h4>");
                    out.println("<p>Student Name: " + rs.getString("student_name") + "</p>");
                    out.println("<p>Registration Number: " + rs.getString("reg") + "</p>");
                    out.println("<form action='rooms.jsp' method='post' class='update-form'>");
                    out.println("<input type='hidden' name='reg' value='" + rs.getString("reg") + "'/>");
                    out.println("<input type='text' name='newRoomNumber' placeholder='Enter new room number' required>");
                    out.println("<button type='submit'>Update Room</button>");
                    out.println("</form>");
                    out.println("</div>");
                }
                rs.close();
                pstmt.close();

                // Update room number if parameters are provided
                if (newRoomNumber != null && reg != null) {
                    pstmt = conn.prepareStatement("SELECT COUNT(*) AS count FROM student WHERE room_number = ?");
                    pstmt.setInt(1, Integer.parseInt(newRoomNumber));
                    rs = pstmt.executeQuery();
                    if (rs.next() && rs.getInt("count") < 2) {
                        pstmt = conn.prepareStatement("UPDATE student SET room_number = ? WHERE reg = ?");
                        pstmt.setInt(1, Integer.parseInt(newRoomNumber));
                        pstmt.setInt(2, Integer.parseInt(reg));
                        int updated = pstmt.executeUpdate();
                        if (updated > 0) {
                            message = "Room updated successfully!";
                            messageType = "success";
                        } else {
                            message = "No update made. Student not found.";
                            messageType = "error";
                        }
                    } else {
                        message = "Room is full. Cannot move student to this room.";
                        messageType = "error";
                    }
                    showMessage = true;
                }
            } catch (SQLException se) {
                message = "Error: " + se.getMessage();
                messageType = "error";
                showMessage = true;
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { }
                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { }
                if (conn != null) try { conn.close(); } catch (SQLException e) { }
            }
        %>
        <% if (showMessage) { %>
            <div class='message-container'>
                <div class='message <%= messageType %>'><%= message %></div>
            </div>
        <% } %>
    </div>

    <footer>
        <p>© 2024 Hostel Management System. All rights reserved.</p>
    </footer>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>