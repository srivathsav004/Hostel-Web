import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.annotation.WebServlet;

@WebServlet("/fetchStudentData")
public class FetchStudentDataServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String regNumber = request.getParameter("reg");

        // Database connection details
        String jdbcUrl = "jdbc:mysql://localhost:3306/wt";
        String username = "root";
        String password = "";
        String jdbcDriver = "com.mysql.cj.jdbc.Driver";

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            Class.forName(jdbcDriver);
            connection = DriverManager.getConnection(jdbcUrl, username, password);
            String sql = "SELECT * FROM student WHERE reg = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, regNumber);

            resultSet = preparedStatement.executeQuery();

            // Building HTML table data
            StringBuilder htmlResponse = new StringBuilder();
            while (resultSet.next()) {
                htmlResponse.append("<tr>");
                htmlResponse.append("<td>").append(resultSet.getString("student_name")).append("</td>");
                htmlResponse.append("<td>").append(resultSet.getInt("reg")).append("</td>");
                htmlResponse.append("<td>").append(resultSet.getString("email")).append("</td>");
                htmlResponse.append("<td>").append(resultSet.getString("dept")).append("</td>");
                htmlResponse.append("<td>").append(resultSet.getInt("year")).append("</td>");
                htmlResponse.append("<td>").append(resultSet.getString("course")).append("</td>");
                htmlResponse.append("<td>").append(resultSet.getInt("room_number")).append("</td>");
                htmlResponse.append("</tr>");
            }
            out.print(htmlResponse.toString());
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("Error: " + e.getMessage());
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}