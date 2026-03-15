<%@ page import="java.sql.*, com.example.portal.DBUtil" %>
<%@ page session="true" %>
<%
 String role = (String) session.getAttribute("role");
 if (role==null || !"student".equals(role)) { 
    response.sendRedirect("login.jsp"); 
    return; 
 }
%>
<html>
<head>
    <title>Student Dashboard</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            font-family: "Segoe UI", Arial, sans-serif;
            background: #f5f7fa;
            margin: 0;
            padding: 0;
            color: #333;
        }

        header {
            background: #2563eb;
            color: white;
            padding: 15px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
        }

        header h2 {
            margin: 0;
            font-weight: 600;
        }

        .logout-btn {
            background: #f43f5e;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            color: white;
            font-size: 14px;
            cursor: pointer;
            transition: 0.3s;
        }

        .logout-btn:hover {
            background: #dc2626;
        }

        .container {
            max-width: 1000px;
            margin: 40px auto;
            padding: 20px;
        }

        h3 {
            color: #1e3a8a;
            border-left: 4px solid #2563eb;
            padding-left: 10px;
            font-weight: 600;
            margin-bottom: 20px;
        }

        .job {
            background: #fff;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .job:hover {
            transform: translateY(-3px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.12);
        }

        .job strong {
            font-size: 18px;
            color: #111827;
        }

        .job p {
            margin: 6px 0;
            line-height: 1.5;
        }

        .job a {
            display: inline-block;
            background: #2563eb;
            color: white;
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 6px;
            font-size: 14px;
            margin-top: 8px;
            transition: 0.3s;
        }

        .job a:hover {
            background: #1d4ed8;
        }

        footer {
            text-align: center;
            color: #6b7280;
            padding: 15px 0;
            margin-top: 30px;
            font-size: 14px;
        }

        @media (max-width: 768px) {
            header {
                flex-direction: column;
                text-align: center;
                gap: 10px;
            }
            .container {
                padding: 10px;
            }
            .job {
                padding: 15px;
            }
        }
    </style>
</head>
<body>
    <header>
        <h2>Student Dashboard</h2>
        <div>
            <span>Welcome, Student </span>
            <form action="login.jsp" method="post" style="display:inline;">
                <button class="logout-btn">Logout</button>
            </form>
        </div>
    </header>

    <div class="container">
        <h3>Available Jobs</h3>

        <%
            java.sql.Connection conn=null; 
            java.sql.PreparedStatement ps=null; 
            java.sql.ResultSet rs=null;
            try {
                conn = DBUtil.getConnection();
                ps = conn.prepareStatement("SELECT * FROM jobs ORDER BY posted_at DESC");
                rs = ps.executeQuery();
                boolean hasJobs = false;
                while (rs.next()) {
                    hasJobs = true;
        %>
            <div class="job">
                <strong><%= rs.getString("title") %></strong> - <%= rs.getString("company_name") %>
                <p><%= rs.getString("description") %></p>
                <p><strong>Eligibility:</strong> <%= rs.getString("eligibility") %> | 
                   <strong>CTC:</strong> <%= rs.getString("ctc") %></p>
                <a href="apply.jsp?jobId=<%= rs.getInt("id") %>">Apply</a>
            </div>
        <%
                }
                if (!hasJobs) {
        %>
            <p style="color:#6b7280;">No jobs available at the moment. Check back later!</p>
        <%
                }
            } catch(Exception e) {
                out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            } finally { 
                DBUtil.close(rs, ps, conn); 
            }
        %>
    </div>

    <footer>
        © 2025 Campus Recruitment Portal — Student Panel
    </footer>
</body>
</html>