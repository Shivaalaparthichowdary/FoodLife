<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="util.DBConnection" %>
<!DOCTYPE html>
<html>
<head><title>DB Test</title></head>
<body>
<%
    try {
        Connection conn = DBConnection.getConnection();
        if (conn != null && !conn.isClosed()) {
            out.println("<h2>Database Connection Successful!</h2>");
        } else {
            out.println("<h2>Database Connection Failed!</h2>");
        }
    } catch (Exception e) {
        out.println("<h2>Error: " + e.getMessage() + "</h2>");
        e.printStackTrace(new java.io.PrintWriter(out));
    }
%>
</body>
</html>
