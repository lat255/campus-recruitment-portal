package com.example.portal;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.nio.file.Paths;
import java.sql.*;

@WebServlet("/apply")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1MB
        maxFileSize = 5 * 1024 * 1024,          // 5MB
        maxRequestSize = 10 * 1024 * 1024)      // 10MB
public class ApplyServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession s = req.getSession(false);
        if (s==null || !"student".equals(s.getAttribute("role"))) {
            resp.sendRedirect("login.jsp");
            return;
        }
        int studentId = (int) s.getAttribute("userId");

        int jobId = Integer.parseInt(req.getParameter("jobId"));
        String name = req.getParameter("name");
        String degree = req.getParameter("degree");
        String cgpa = req.getParameter("cgpa");
        String backlogs = req.getParameter("backlogs");

        Part filePart = req.getPart("resume");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        // Save uploaded file to webapp/uploads/<uniqueName>
        String uploadsDir = req.getServletContext().getRealPath("/") + "uploads";
        File uploads = new File(uploadsDir);
        if (!uploads.exists()) uploads.mkdirs();

        String unique = System.currentTimeMillis() + "_" + fileName;
        File file = new File(uploads, unique);
        try (InputStream in = filePart.getInputStream(); FileOutputStream out = new FileOutputStream(file)) {
            byte[] buf = new byte[1024];
            int read;
            while ((read = in.read(buf)) != -1) out.write(buf,0,read);
        }

        String resumePath = "uploads/" + unique; // relative path

        // Insert into DB
        Connection conn=null; PreparedStatement ps=null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement("INSERT INTO applications (job_id, student_id, name, degree, cgpa, backlogs, resume_path) VALUES (?,?,?,?,?,?,?)");
            ps.setInt(1, jobId);
            ps.setInt(2, studentId);
            ps.setString(3, name);
            ps.setString(4, degree);
            ps.setString(5, cgpa);
            ps.setString(6, backlogs);
            ps.setString(7, resumePath);
            ps.executeUpdate();

            req.setAttribute("message", "Application submitted successfully!");
            req.getRequestDispatcher("apply.jsp?jobId=" + jobId).forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        } finally {
            DBUtil.close(null, ps, conn);
        }
    }
}