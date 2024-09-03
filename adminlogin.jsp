<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>
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

        #error-message {
            color: red;
            text-align: center;
            margin-top: 10px;
            display: none;
        }

        .container1 {
            max-width: 1200px;
            margin: 5px auto;
            padding: 0 20px;
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
                <li><a href="http://localhost:8080/hostel/about.jsp">About</a></li>
                <li><a href="#" class="active">Admin Login</a></li>
                <li><a href="http://localhost:8080/hostel/studentlogin.jsp">Student Login</a></li>
            </ul>
        </nav>
    </header>

    <div class="container">
        <h1>Admin Login</h1>
        <form id="admin-login-form">
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
        <div id="error-message"></div>
    </div>

    <footer>
        <p>© 2024 Hostel Management System. All rights reserved.</p>
    </footer>

    <script>
        const adminCredentials = [
            { username: 'admin', password: 'admin123' },
        ];
        function adminLogin(event) {
            event.preventDefault(); 
            const username = document.getElementById('username').value;
            const password = document.getElementById('password').value;
            const isAdmin = adminCredentials.some(credential => {
                return credential.username === username && credential.password === password;
            });

            if (isAdmin) {
                window.location.href = 'http://localhost:8080/hostel/admin/fetchstudents.jsp'; 
            } else {
                const errorMessage = document.getElementById('error-message');
                errorMessage.style.display = 'block';
                errorMessage.textContent = 'Invalid username or password. Please try again.';
            }
        }

        const adminLoginForm = document.getElementById('admin-login-form');
        if (adminLoginForm) {
            adminLoginForm.addEventListener('submit', adminLogin);
        } else {
            console.error('Admin login form not found');
        }
    </script>
</body>
</html>
