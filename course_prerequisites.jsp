<html>


<body>
    
            <%-- Set the scripting language to Java and --%>
            <%-- Import the java.sql package --%>
            <%@ page language="java" import="java.sql.*" %>
    
            <%-- -------- Open Connection Code -------- --%>
            <%
                try {
                    Class.forName("org.postgresql.Driver");
                    String dbURL = "jdbc:postgresql://127.0.0.1/cse132";
                    Connection conn = DriverManager.getConnection(dbURL, "postgres", "admin");

            %>

            <%-- -------- INSERT Code -------- --%>
            <%
                    String action = request.getParameter("action");
                    // Check if an insertion is requested
                    if (action != null && action.equals("insert")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the course_prerequisites  attributes INTO the course_prerequisites  table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO course_prerequisites VALUES (?, ?)");

                        pstmt.setString(1, request.getParameter("course_id"));
                        pstmt.setString(2, (request.getParameter("prerequisites_course_id")));

                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);

                        response.sendRedirect("course.jsp");
                    }
            %>

            <%-- -------- UPDATE Code -------- --%>
            <%
                    // Check if an update is requested
                    if (action != null && action.equals("update")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // UPDATE the course_prerequisites  attributes in the course_prerequisites  table.
                        PreparedStatement pstmt = conn.prepareStatement("UPDATE course_prerequisites SET prerequisites_course_id = ?, course_id = ? WHERE prerequisites_course_id = ? and course_id = ?");

                        pstmt.setString(1, request.getParameter("prerequisites_course_id"));
                        pstmt.setString(2, request.getParameter("course_id"));
                        pstmt.setString(3, request.getParameter("old_prerequisites_course_id"));
                        pstmt.setString(4, request.getParameter("old_course_id"));

                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                        response.sendRedirect("course.jsp");
                    }
            %>

            <%-- -------- DELETE Code -------- --%>
            <%
                    // Check if a delete is requested
                    if (action != null && action.equals("delete")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // DELETE the course_prerequisites  FROM the course_prerequisites  table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM course_prerequisites WHERE course_id = ? AND prerequisites_course_id = ?");

                        pstmt.setString(1, request.getParameter("course_id"));
                        pstmt.setString(2, request.getParameter("prerequisites_course_id"));

                        
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                        response.sendRedirect("course.jsp");
                    }
            %>

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    Statement statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the course_prerequisites  attributes FROM the course_prerequisites  table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM course_prerequisites ");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <h4 >prerequisite information</h4>
                

                    <tr>

                        <th>course_id</th>
                        <th>prerequisites_course_id</th>

                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="course_prerequisites.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="course_id" size="10"></th>
                            <th><input value="" name="prerequisites_course_id" size="10"></th>

                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {

            %>

                    <tr>
                        <form action="course_prerequisites.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the course_id, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("course_id") %>" 
                                    name="course_id" size="10" readonly="true">
                            </td>
    
                            <%-- Get the prerequisites_course_id --%>
                            <td>
                                <input value="<%= rs.getString("prerequisites_course_id") %>" 
                                    name="prerequisites_course_id" size="10">
                            </td>

                            <input type="hidden"
                                value="<%= rs.getString("course_id") %>" name="old_course_id">

                            <input type="hidden"
                                value="<%= rs.getString("prerequisites_course_id") %>" name="old_prerequisites_course_id">
       
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="course_prerequisites.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden"
                                value="<%= rs.getString("course_id") %>" name="course_id">
                            <input type="hidden"
                                value="<%= rs.getString("prerequisites_course_id") %>" name="prerequisites_course_id">
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Delete">
                            </td>
                        </form>
                    </tr>
            <%
                    }
            %>

            <%-- -------- Close Connection Code -------- --%>
            <%
                    // Close the ResultSet
                    rs.close();
    
                    // Close the Statement
                    statement.close();
    
                    // Close the Connection
                    conn.close();
                } catch (SQLException sqle) {
                    out.println(sqle.getMessage());
                } catch (Exception e) {
                    out.println(e.getMessage());
                }
            %>
                </table>
            
</body>

</html>

