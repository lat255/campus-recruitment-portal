<%@ page import="java.sql.*, com.example.portal.DBUtil" %>
<%@ page session="true" %>
<%
  String role = (String) session.getAttribute("role");
  if (role == null || !"recruiter".equals(role)) {
    response.sendRedirect("login.jsp");
    return;
  }
%>
<html>
<head>
    <title>Recruiter Dashboard</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            font-family: "Segoe UI", Arial, sans-serif;
            background: #f4f7fb;
            margin: 0;
            padding: 0;
            color: #333;
        }

        header {
            background: #1e3a8a;
            color: #fff;
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

        .container {
            max-width: 1000px;
            margin: 40px auto;
            padding: 20px;
        }

        h3 {
            color: #1e3a8a;
            border-left: 4px solid #1e3a8a;
            padding-left: 10px;
            font-weight: 600;
        }

        form {
            background: #fff;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
            margin-bottom: 40px;
        }

        form input, form textarea {
            width: 100%;
            margin-bottom: 15px;
            padding: 10px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            font-size: 15px;
        }

        form textarea {
            resize: vertical;
            height: 80px;
        }

        form button {
            background: #2563eb;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            font-size: 15px;
            cursor: pointer;
            transition: 0.3s;
        }

        form button:hover {
            background: #1d4ed8;
        }
        
        .logout-btn {
            background: #f43f5e;
            color: #fff;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            transition: 0.3s;
        }

        .logout-btn:hover {
            background: #dc2626;
        }

        .job {
            background: #fff;
            padding: 20px;
            margin-bottom: 15px;
            border-radius: 10px;
            box-shadow: 0 1px 8px rgba(0, 0, 0, 0.06);
            transition: transform 0.2s ease;
        }

        .job:hover {
            transform: translateY(-2px);
        }

        .job strong {
            color: #111827;
            font-size: 18px;
        }

        .job p {
            margin: 6px 0;
            line-height: 1.4;
        }

        .job a {
            color: #2563eb;
            text-decoration: none;
            font-weight: 500;
        }

        .job a:hover {
            text-decoration: underline;
        }

        footer {
            text-align: center;
            color: #6b7280;
            margin-top: 30px;
            padding: 15px 0;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <header>
        <h2>Recruiter Dashboard</h2>
        <div>
            <span>Welcome, Recruiter</span>
            <form action="login.jsp" method="post" style="display:inline;">
                <button class="logout-btn">Logout</button>
            </form>
        </div>
    </header>

    <div class="container">
        <h3>Post a Job</h3>
        <form method="post" action="postJob">
            <input name="companyName" placeholder="Company Name" required>
            <input name="title" placeholder="Job Title" required>
            <textarea name="description" placeholder="Job Description"></textarea>
            <input name="eligibility" placeholder="Eligibility">
            <input name="ctc" placeholder="CTC">
            <button type="submit">Submit</button>
        </form>

        <h3>Your Posted Jobs</h3>
        <%
            java.sql.Connection conn = null;
            java.sql.PreparedStatement ps = null;
            java.sql.ResultSet rs = null;
            try {
                conn = DBUtil.getConnection();
                ps = conn.prepareStatement("SELECT * FROM jobs WHERE posted_by = ? ORDER BY posted_at DESC");
                ps.setInt(1, (Integer) session.getAttribute("userId"));
                rs = ps.executeQuery();
                boolean hasJobs = false;
                while (rs.next()) {
                    hasJobs = true;
        %>
        <div class="job">
            <strong><%= rs.getString("title") %></strong> - <%= rs.getString("company_name") %>
            <p><%= rs.getString("description") %></p>
            <p><strong>Eligibility:</strong> <%= rs.getString("eligibility") %> | <strong>CTC:</strong> <%= rs.getString("ctc") %></p>
            <a href="viewApplications?jobId=<%= rs.getInt("id") %>">View Applications</a>
        </div>
        <%
                }
                if (!hasJobs) {
        %>
        <p style="color: #6b7280;">No jobs posted yet.</p>
        <%
                }
            } catch (Exception e) {
                out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            } finally {
                DBUtil.close(rs, ps, conn);
            }
        %>
    </div>

    <footer>
        © 2025 Campus Recruitment Portal — Recruiter Panel
    </footer>
</body>
</html>