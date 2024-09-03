<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Page</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
            color: #333;
        }

        header {
            background-color: #343a40;
            padding: 10px 0;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
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
            max-width: 1200px;
            margin: 5px auto;
            padding: 0 20px;
            margin-bottom: 100px;
        }

        .module {
            margin-top: 30px;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
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
                <li><a href="#" class="active">About</a></li>
                <li><a href="http://localhost:8080/hostel/adminlogin.jsp">Admin Login</a></li>
                <li><a href="http://localhost:8080/hostel/studentlogin.jsp">Student Login</a></li>
            </ul>
        </nav>
    </header>

    <div class="container">
        <h1>About Us</h1>
        <div class="module">
            <h2>Project Description</h2>
            <p>The Hostel Management System is a web-based application designed to streamline the management of hostel facilities in educational institutions. It provides functionalities for user authentication, room management, notice issuance, complaints handling, student data management, and payment submissions.</p>
        </div>

        <div class="module">
            <h2>Objectives</h2>
            <ul>
                <li>Provide a secure and efficient platform for managing hostel facilities.</li>
                <li>Automate processes such as room allocation, notice dissemination, and complaints handling.</li>
                <li>Facilitate seamless communication between administrators and students.</li>
                <li>Ensure accurate record-keeping of student data and financial transactions.</li>
            </ul>
        </div>

        <div class="module">
            <h2>Technologies Used</h2>
            <ul>
                <li>Java Servlets and JSP for server-side development.</li>
                <li>JavaScript for client-side validation and interaction.</li>
                <li>JDBC for database connectivity with MySQL.</li>
                <li>PHP for handling payment submissions.</li>
                <li>HTML, CSS, and Bootstrap for front-end design.</li>
            </ul>
        </div>
        <h1>Modules</h1>
        <div class="module">
            <h2>User Authentication</h2>
            <p>User authentication allows admins and students to access their respective panels. Admin login and student login pages validate credentials using JavaScript and handle redirection. Session management ensures secure access.</p>
            <p><a href="http://localhost:8080/hostel/adminlogin.jsp">Admin Login</a> | <a href="http://localhost:8080/hostel/studentlogin.jsp">Student Login</a></p>
        </div>

        <div class="module">
            <h2>Managing Rooms</h2>
            <p>Admins can manage rooms, assign students, and update room occupancy. JDBC connectivity is used to interact with the MySQL database.</p>
            <p><a href="http://localhost:8080/hostel/admin/rooms.jsp">Manage Rooms</a></p>
        </div>

        <div class="module">
            <h2>Notice Management</h2>
            <p>Admins can issue notices that are displayed to students in descending order of time. JDBC connectivity is used for interaction with the MySQL database.</p>
            <p><a href="http://localhost:8080/hostel/admin/notice.jsp">Notice Board</a></p>
        </div>

        <div class="module">
            <h2>Complaints Handling</h2>
            <p>Students can submit complaints, which are received and managed by admins. Interaction with the MySQL database is facilitated using JDBC.</p>
            <p><a href="http://localhost:8080/hostel/student/complaints.jsp">Complaint Board</a></p>
        </div>

        <div class="module">
            <h2>Student Management</h2>
            <p>Admins can add and manage student data, issue usernames, and passwords. JDBC connectivity is used for interaction with the MySQL database.</p>
            <p><a href="http://localhost:8080/hostel/admin/fetchstudents.jsp">Student Data</a></p>
        </div>

        <div class="module">
            <h2>Payment Submission</h2>
            <p>Students can submit payment receipts, which are fetched by admins. PHP is used for handling payment submissions.</p>
            <p><a href="http://localhost:8080/hostel/student/payment.jsp">Payment</a></p>
        </div>
    </div>

    <footer>
        <p>© 2024 Hostel Management System. All rights reserved.</p>
    </footer>
</body>
</html>
