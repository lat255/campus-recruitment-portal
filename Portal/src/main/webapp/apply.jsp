<%@ page session="true" %>
<%
 String role = (String) session.getAttribute("role");
 if (role == null || !"student".equals(role)) { 
    response.sendRedirect("login.jsp"); 
    return; 
 }
 String jobId = request.getParameter("jobId");
%>
<html>
<head>
    <title>Apply for Job</title>
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
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
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

        .form-container {
            max-width: 600px;
            margin: 60px auto;
            background: #fff;
            border-radius: 12px;
            padding: 30px 40px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.08);
        }

        h2 {
            text-align: center;
            color: #000000;
            font-weight: 600;
            margin-bottom: 25px;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        form input[type="text"],
        form input[type="number"],
        form input[type="file"],
        form input[type="hidden"],
        form input[name],
        form textarea {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            font-size: 15px;
            box-sizing: border-box;
        }

        form label {
            font-weight: 500;
            color: #1e3a8a;
        }

        form button {
            background: #2563eb;
            color: white;
            border: none;
            padding: 10px 18px;
            border-radius: 8px;
            font-size: 15px;
            cursor: pointer;
            transition: background 0.3s;
            align-self: flex-end;
        }

        form button:hover {
            background: #1d4ed8;
        }

        .message {
            text-align: center;
            color: green;
            font-weight: 500;
            margin-bottom: 15px;
        }

        .back-link {
            text-align: center;
            margin-top: 20px;
        }

        .back-link a {
            text-decoration: none;
            color: #2563eb;
            font-weight: 500;
        }

        .back-link a:hover {
            text-decoration: underline;
        }

        footer {
            text-align: center;
            color: #6b7280;
            padding: 15px 0;
            margin-top: 40px;
            font-size: 14px;
        }

        @media (max-width: 768px) {
            .form-container {
                margin: 30px 15px;
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <header>
        <h2>Apply for Job</h2>
        <div>
            <span>Welcome, Student</span>
            <form action="login.jsp" method="post" style="display:inline;">
                <button class="logout-btn">Logout</button>
            </form>
        </div>
    </header>

    <div class="form-container">
        <c:if test="${not empty message}">
            <p class="message">${message}</p>
        </c:if>

        <form method="post" action="apply" enctype="multipart/form-data">
            <input type="hidden" name="jobId" value="<%=jobId%>">

            <input name="name" placeholder="Full Name" value="${sessionScope.fullname}" required>
            <input name="degree" placeholder="Degree" required>
            <input name="cgpa" placeholder="CGPA" required>
            <input name="backlogs" placeholder="Backlogs (if any)">
            
            <label>Upload Resume (PDF/DOC):</label>
            <input type="file" name="resume" accept=".pdf,.doc,.docx" required>

            <button type="submit">Submit Application</button>
        </form>

        <div class="back-link">
            <a href="student.jsp">← Back to Dashboard</a>
        </div>
    </div>

    <footer>
        © 2025 Campus Recruitment Portal — Application Page
    </footer>
</body>
</html>