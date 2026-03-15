<%@ page import="java.util.*" %>
<%@ page session="true" %>
<%
  String role = (String) session.getAttribute("role");
  if (role==null || !"recruiter".equals(role)) { response.sendRedirect("login.jsp"); return; }
  List<Map<String,Object>> apps = (List<Map<String,Object>>) request.getAttribute("applications");
%>
<html><head><title>Applications</title><link rel="stylesheet" href="css/style.css"></head>
<body>
  <h2>Applications for Job</h2>
  <%
    if (apps==null || apps.isEmpty()) {
      out.println("<p>No applications yet.</p>");
    } else {
      for (Map<String,Object> a : apps) {
  %>
      <div>
        <p><strong><%= a.get("name") %></strong> (<%= a.get("username") %>)</p>
        <p>Degree: <%= a.get("degree") %> | CGPA: <%= a.get("cgpa") %> | Backlogs: <%= a.get("backlogs") %></p>
        <p><a href="<%= a.get("resume") %>" target="_blank">Download Resume</a></p>
      </div>
  <%
      }
    }
  %>
  <p><a href="recruiter.jsp">Back</a></p>
</body></html>