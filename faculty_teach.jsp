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
                        // INSERT the faculty_teach  attributes INTO the faculty_teach  table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO faculty_teach VALUES (?,?, ?, ?)");

                        pstmt.setString(1, request.getParameter("faculty_id"));
                        pstmt.setString(2, (request.getParameter("course_id")));
                        pstmt.setString(3, (request.getParameter("section_id")));
                        pstmt.setString(4, request.getParameter("teach_time"));
                        
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);

                        response.sendRedirect("faculty.jsp");
                    }
            %>

            <%-- -------- UPDATE Code -------- --%>
            <%
                    // Check if an update is requested
                    if (action != null && action.equals("update")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // UPDATE the faculty_teach  attributes in the faculty_teach  table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE faculty_teach SET course_id = ?, section_id = ?, " +
                            "teach_time = ? WHERE faculty_id = ? and course_id = ? and section_id = ? and teach_time = ?");


                        
                        pstmt.setString(1, request.getParameter("course_id"));
                        pstmt.setString(2, request.getParameter("section_id"));
                        pstmt.setString(3, request.getParameter("teach_time"));

                        pstmt.setString(4, request.getParameter("faculty_id"));
                        pstmt.setString(5, request.getParameter("old_course_id"));
                        pstmt.setString(6, request.getParameter("old_section_id"));
                        pstmt.setString(7, request.getParameter("old_teach_time"));


                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);

                        response.sendRedirect("faculty.jsp");
                    }
            %>

            <%-- -------- DELETE Code -------- --%>
            <%
                    // Check if a delete is requested
                    if (action != null && action.equals("delete")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // DELETE the faculty_teach  FROM the faculty_teach  table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM faculty_teach WHERE faculty_id = ? and course_id = ? and section_id = ? and teach_time = ?");

                        pstmt.setString(1, request.getParameter("faculty_id"));
                        pstmt.setString(2, request.getParameter("course_id"));
                        pstmt.setString(3, request.getParameter("section_id"));
                        pstmt.setString(4, request.getParameter("teach_time"));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);

                        response.sendRedirect("faculty.jsp");
                    }
            %>

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    Statement statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the faculty_teach  attributes FROM the faculty_teach  table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM faculty_teach order by faculty_id");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <h4> faculty teaching sections:</h4>
                        <th>faculty_id</th>
                        <th>course_id</th>
                       <th> section_id</th>
                       <th>teach_time</th>

                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="faculty_teach.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="faculty_id" size="10"></th>
                            <th><input value="" name="course_id" size="10"></th>
                            <th><input value="" name="section_id" size="15"></th>
						    <th><input value="" name="teach_time" size="15"></th>

                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {

            %>

                    <tr>
                        <form action="faculty_teach.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the faculty_id, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("faculty_id") %>" 
                                    name="faculty_id" size="10">
                            </td>

                            <td>
                                <input value="<%= rs.getString("course_id") %>" 
                                    name="course_id" size="10">
                            </td>
    
                            
    
                            <%-- Get the section_id --%>
                            <td>
                                <input value="<%= rs.getString("section_id") %>"
                                    name="section_id" size="15">
                            </td>
    
                            <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs.getString("teach_time") %>" 
                                    name="teach_time" size="15">
                            </td>

                            <input type="hidden" 
                                value="<%= rs.getString("course_id") %>" name="old_course_id">
                                <input type="hidden" 
                                value="<%= rs.getString("section_id") %>" name="old_section_id">
                                <input type="hidden" 
                                value="<%= rs.getString("teach_time") %>" name="old_teach_time">
    
			   			       
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="faculty_teach.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getString("faculty_id") %>" name="faculty_id">
                                <input type="hidden" 
                                value="<%= rs.getString("course_id") %>" name="course_id">
                                <input type="hidden" 
                                value="<%= rs.getString("section_id") %>" name="section_id">
                                <input type="hidden" 
                                value="<%= rs.getString("teach_time") %>" name="teach_time">
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