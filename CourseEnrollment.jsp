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

                        String qry = "select count(*) from class join course on class.course_id = course.course_id join section on class.class_id = section.class_id where course.course_id = ? and section.section_id = ? ";
                        PreparedStatement pre_pstmt = conn.prepareStatement(qry);
                        pre_pstmt.setString(1, request.getParameter("course"));
                        pre_pstmt.setString(2, request.getParameter("section"));

                        ResultSet checkRs = pre_pstmt.executeQuery();
                        Long pairCheck = new Long(0);
                        if(checkRs.next()){
                            pairCheck = (Long) checkRs.getObject("count");
                            //out.println("joined table size: " + pairCheck);
                        }
                        if(pairCheck > 0 ) {

                            String qry2 = "select count(*) from course_units where course_id = ? and units = ? ";
                            PreparedStatement pre_pstmt2 = conn.prepareStatement(qry2);
                            pre_pstmt2.setString(1, request.getParameter("course"));
                            
                            pre_pstmt2.setInt(
                            2, Integer.parseInt(request.getParameter("units")));

                            ResultSet checkRs2 = pre_pstmt2.executeQuery();
                            Long pairCheck2 = new Long(0);
                            if(checkRs2.next()){
                                pairCheck2 = (Long) checkRs2.getObject("count");
                                //out.println("course_unit found: " + pairCheck2);
                            }

                            if(pairCheck2 > 0 ) {

                            //
                            PreparedStatement pstmt = conn.prepareStatement(
                                "INSERT INTO course_enrollment VALUES (?, ?, ?, ?,?,?)");

                            
                            
                            pstmt.setString(1, request.getParameter("student"));
                            pstmt.setString(2, request.getParameter("course"));
                            pstmt.setString(3, request.getParameter("section"));
                            pstmt.setInt(4, Integer.parseInt(request.getParameter("units")));
                            pstmt.setString(5, request.getParameter("grading"));
                            pstmt.setString(6, request.getParameter("quarter")); // + "2021"
                            
                            int rowCount = pstmt.executeUpdate();

                            // Commit transaction
                            conn.commit();
                            conn.setAutoCommit(true);
                          }
                        } 
                        
                    }
            %>

            <%-- -------- UPDATE Code -------- --%>
            <%
                    // Check if an update is requested
                    if (action != null && action.equals("update")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // UPDATE the student attributes in the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE course_enrollment SET course_id = ?, units = ?, section_id = ?, quarter = ?, grading_option = ?" +
                            "WHERE student_id = ? and section_id = ? ");

                        pstmt.setString(1, request.getParameter("course"));
                        pstmt.setInt(
                            2, Integer.parseInt(request.getParameter("units")));
                        pstmt.setString(3, request.getParameter("section"));
                        pstmt.setString(4, "quarter");
                        pstmt.setString(5, request.getParameter("grading"));
                        pstmt.setString(6, request.getParameter("student"));
                        pstmt.setString(7, request.getParameter("oldSection"));
                        
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
                        // DELETE the student FROM the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM course_enrollment WHERE student_id = ? and section_id = ?");

                        pstmt.setString(1, request.getParameter("student"));
                        pstmt.setString(2, request.getParameter("section"));
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
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("select * from course_enrollment as ce, course as cn where ce.course_id = cn.course_id order by student_id");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <h4>Course Enrollment</h4>
                        <th>studentID</th>
                        <th>courseNumber</th>
                        <th>courseID</th>
                        <th>sectionID</th>
			            <th>units</th>
                        <th>grading_option</th>
                        <th>quarter</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="CourseEnrollment.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="student" size="10"></th>
                            <th><input value="" name="course_number" size="10"></th>
                            <th><input value="" name="course" size="10"></th>
                            <th><input value="" name="section" size="15"></th>
			    <th><input value="" name="units" size="15"></th>
                <th><input value="" name="grading" size="15"></th>
                <th><input value="" name="quarter" size="15"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="CourseEnrollment.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs.getString("student_id") %>" 
                                    name="student" size="15" readonly="true">
                            </td>

                            <td>
                                <input value="<%= rs.getString("course_number") %>"
                                    name="course_number" size="15">
                            </td>

                            <%-- Get the FIRSTNAME --%>
                            <td>
                                <input value="<%= rs.getString("course_id") %>"
                                    name="course" size="15">
                            </td>
    
                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getString("section_id") %>" 
                                    name="section" size="10">
                            </td>

                            <%-- Get the courseID, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("units") %>" 
                                    name="units" size="10">
                            </td>

                            <td>
                                <input value="<%= rs.getString("grading_option") %>" 
                                    name="grading" size="10">
                            </td>

                            <td>
                                <input value="<%= rs.getString("quarter") %>" 
                                    name="quarter" size="10">
                            </td>

                            <input type="hidden" 
                                value="<%= rs.getString("section_id") %>" name="oldSection">
    
                            
    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="CourseEnrollment.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getString("section_id") %>" name="section">
                            <input type="hidden" 
                                value="<%= rs.getString("student_id") %>" name="student">
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
        <tr>
            <td> </td>
            <td>
                <jsp:include page="course_waitlist.jsp" />
            </td>
        </tr>
    </table>
</body>

</html>
