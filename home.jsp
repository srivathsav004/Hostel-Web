<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, javax.xml.parsers.*, org.w3c.dom.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hostel Management System</title>
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

        .carousel-container {
            position: relative;
            max-width: 100%;
            margin-top: 60px; 
            overflow: hidden;
        }

        .carousel {
            display: flex;
            transition: transform 1s ease-in-out;
        }

        .slide {
            flex: 0 0 100%; 
            max-width: 100%; 
        }

        .hostel-details, .rules-regulations {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .hostel-details h2, .rules-regulations h2 {
            color: #333;
        }

        .rules-regulations ul {
            padding-left: 20px;
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
                <li><a href="#" class="active">Home</a></li>
                <li><a href="http://localhost:8080/hostel/about.jsp">About Project</a></li>
                <li><a href="http://localhost:8080/hostel/adminlogin.jsp">Admin Login</a></li>
                <li><a href="http://localhost:8080/hostel/studentlogin.jsp">Student Login</a></li>
            </ul>
        </nav>
    </header>
    <div class="carousel-container">
        <div class="carousel">
            <img src="img/1.jpg" alt="Image 1" class="slide">
            <img src="img/2.jpg" alt="Image 2" class="slide">
            <img src="img/3.jpg" alt="Image 3" class="slide">
        </div>
    </div>
    <section class="hostel-details">
        <%
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(getServletContext().getResourceAsStream("/hostel_info.xml"));
            doc.getDocumentElement().normalize();

            Node detailsNode = doc.getElementsByTagName("details").item(0);
            if (detailsNode.getNodeType() == Node.ELEMENT_NODE) {
                Element detailsElement = (Element) detailsNode;
        %>
            <h2>Hostel Details</h2>
            <p><strong>Name:</strong> <%= detailsElement.getElementsByTagName("name").item(0).getTextContent() %></p>
            <p><strong>Location:</strong> <%= detailsElement.getElementsByTagName("location").item(0).getTextContent() %></p>
            <p><strong>Address:</strong> <%= detailsElement.getElementsByTagName("address").item(0).getTextContent() %></p>
            <p><strong>Details:</strong> <%= detailsElement.getElementsByTagName("description").item(0).getTextContent() %></p>
        <%
            }
        %>
    </section>
    <section class="rules-regulations">
        <h2>Rules and Regulations</h2>
        <ul>
        <%
            NodeList ruleNodes = doc.getElementsByTagName("rule");
            for (int i = 0; i < ruleNodes.getLength(); i++) {
                Node ruleNode = ruleNodes.item(i);
                if (ruleNode.getNodeType() == Node.ELEMENT_NODE) {
                    Element ruleElement = (Element) ruleNode;
        %>
                    <li><%= ruleElement.getTextContent() %></li>
        <%
                }
            }
        %>
        </ul>
    </section>
    <footer>
        <p>© 2023 Hostel Management System. All rights reserved.</p>
    </footer>
    <script>
        const carousel = document.querySelector('.carousel');
        let index = 0; // Current slide index
        let slideInterval = setInterval(nextSlide, 3000); // Set slide interval to 3 seconds

        function nextSlide() {
            index = (index + 1) % carousel.children.length; // Update index to show next slide
            carousel.style.transform = 'translateX(-' + index * 100 + '%)'; // Move carousel
        }
    </script>
</body>
</html>