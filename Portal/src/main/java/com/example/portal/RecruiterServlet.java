package com.example.portal;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/viewApplications")
public class RecruiterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String username = (String) session.getAttribute("username");
        int userId = (Integer) session.getAttribute("userId"); // posted_by

        Connection conn = null;
        PreparedStatement psJobs = null;
        ResultSet rsJobs = null;

        try {
            conn = DBUtil.getConnection();

            // Fetch jobs posted by this recruiter
            psJobs = conn.prepareStatement("SELECT * FROM jobs WHERE posted_by=? ORDER BY posted_at DESC");
            psJobs.setInt(1, userId);
            rsJobs = psJobs.executeQuery();

            StringBuilder html = new StringBuilder();
            html.append("<html><head><title>View Applications</title>");
            html.append("<style>");
            html.append("body {font-family: Arial; background-color:#f4f6f9; margin:0; padding:20px;}");
            html.append(".job-card {background:white; padding:15px; margin-bottom:20px; box-shadow:0 2px 6px rgba(0,0,0,0.1); border-radius:10px;}");
            html.append(".apps {background:#f9f9f9; padding:10px; border-radius:8px; margin-top:10px;}");
            html.append(".app-item {border-bottom:1px solid #ccc; padding:6px 0;}");
            html.append(".app-item:last-child {border:none;}");
            html.append("a {color:#007bff; text-decoration:none;} a:hover {text-decoration:underline;}");
            html.append("</style>");
            html.append("</head><body>");
            html.append("<h2>Your Job Postings and Applications</h2>");

            while (rsJobs.next()) {
                int jobId = rsJobs.getInt("id");
                String title = rsJobs.getString("title");
                String company = rsJobs.getString("company_name");

                html.append("<div class='job-card'>");
                html.append("<h3>").append(title).append("</h3>");
                html.append("<p><strong>Company:</strong> ").append(company).append("</p>");
                html.append("<p>Eligibility: ").append(rsJobs.getString("eligibility"))
                    .append(" | CTC: ").append(rsJobs.getString("ctc")).append("</p>");

                // Fetch applications for this job
                try (PreparedStatement psApps = conn.prepareStatement(
                        "SELECT * FROM applications WHERE job_id=?")) {
                    psApps.setInt(1, jobId);
                    try (ResultSet rsApps = psApps.executeQuery()) {
                        html.append("<div class='apps'>");
                        boolean hasApps = false;
                        while (rsApps.next()) {
                            hasApps = true;
                            html.append("<div class='app-item'>");
                            html.append("<strong>").append(rsApps.getString("name")).append("</strong><br>");
                            html.append("Degree: ").append(rsApps.getString("degree")).append("<br>");

                            String cgpaStr = rsApps.getString("cgpa");
                            html.append("CGPA: ").append(cgpaStr != null ? cgpaStr : "NA").append("<br>");

                            String backlogsStr = rsApps.getString("backlogs");
                            html.append("Backlogs: ").append(backlogsStr != null ? backlogsStr : "NA").append("<br>");

                            html.append("<a href='").append(rsApps.getString("resume_path")).append("' target='_blank'>View Resume</a>");
                            html.append("</div>");
                        }
                        if (!hasApps) html.append("<p>No applications yet.</p>");
                        html.append("</div>");
                    }
                }

                html.append("</div>");
            }

            html.append("</body></html>");
            response.setContentType("text/html");
            response.getWriter().write(html.toString());

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<h3>Error: " + e.getMessage() + "</h3>");
        } finally {
            DBUtil.close(rsJobs, psJobs, conn);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
