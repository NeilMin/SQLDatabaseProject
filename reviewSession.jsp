<html>


<body>
    <table border="1">
        <tr>
            <td valign="top">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="menu.html" />
            </td>
            <td>
                
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
                        // INSERT the review_session  attributes INTO the review_session  table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO review_session VALUES (?, ?, ?, ?)");

                        pstmt.setString(1, request.getParameter("class_id"));
                        pstmt.setString(2, (request.getParameter("rtime")));
                        pstmt.setString(3, (request.getParameter("rdate")));
                        pstmt.setString(4, request.getParameter("rlocation"));
                        
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- UPDATE Code -------- --%>
            <%
                    // Check if an update is requested
                    if (action != null && action.equals("update")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // UPDATE the review_session  attributes in the review_session  table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE review_session SET rtime = ?, rdate = ?, " +
                            "rlocation = ? WHERE class_id = ? and rtime=? and rdate = ? and rlocation = ?");


                        pstmt.setString(1, request.getParameter("rtime"));
                        pstmt.setString(2, (request.getParameter("rdate")));
                        pstmt.setString(3, request.getParameter("rlocation"));

                        pstmt.setString(4, request.getParameter("class_id"));

                        pstmt.setString(5, request.getParameter("old_rtime"));
                        pstmt.setString(6, (request.getParameter("old_rdate")));
                        pstmt.setString(7, request.getParameter("old_rlocation"));

                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- DELETE Code -------- --%>
            <%
                    // Check if a delete is requested
                    if (action != null && action.equals("delete")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // DELETE the review_session  FROM the review_session  table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM review_session WHERE class_id = ? and rtime =? and rlocation = ? and rdate = ?");

                        pstmt.setString(1, request.getParameter("class_id"));
                        pstmt.setString(2, request.getParameter("rtime"));
                        pstmt.setString(3, request.getParameter("rlocation"));
                        pstmt.setString(4, request.getParameter("rdate"));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    Statement statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the review_session  attributes FROM the review_session  table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM review_session ");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <h4> review session info submission form</h4>
                        <th>class_id</th>
                        <th>rtime</th>
                       <th> rdate</th>
                       <th>rlocation</th>

                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="reviewSession.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="class_id" size="10"></th>
                            <th><input value="" name="rtime" size="10"></th>
                            <th><input value="" name="rdate" size="15"></th>
						    <th><input value="" name="rlocation" size="15"></th>

                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {

            %>

                    <tr>
                        <form action="reviewSession.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the class_id, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("class_id") %>" 
                                    name="class_id" size="10">
                            </td>
    
                            <%-- Get the rtime --%>
                            <td>
                                <input value="<%= rs.getString("rtime") %>" 
                                    name="rtime" size="15">
                            </td>
    
                            <%-- Get the rdate --%>
                            <td>
                                <input value="<%= rs.getString("rdate") %>"
                                    name="rdate" size="15">
                            </td>
    
                            <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs.getString("rlocation") %>" 
                                    name="rlocation" size="15">
                            </td>

                            <input type="hidden" 
                                value="<%= rs.getString("rtime") %>" name="old_rtime">
                                <input type="hidden" 
                                value="<%= rs.getString("rdate") %>" name="old_rdate">
                                <input type="hidden" 
                                value="<%= rs.getString("rlocation") %>" name="old_rlocation">
    
			   			       
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="reviewSession.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getString("class_id") %>" name="class_id">
                                <input type="hidden" 
                                value="<%= rs.getString("rtime") %>" name="rtime">
                                <input type="hidden" 
                                value="<%= rs.getString("rdate") %>" name="rdate">
                                <input type="hidden" 
                                value="<%= rs.getString("rlocation") %>" name="rlocation">
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
            </td>
        </tr>
    </table>
</body>

</html>

