package com.example.portal;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/jobs")
public class StudentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection conn=null; PreparedStatement ps=null; ResultSet rs=null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement("SELECT j.*, u.fullname as posted_by_name FROM jobs j LEFT JOIN users u ON j.posted_by = u.id ORDER BY j.posted_at DESC");
            rs = ps.executeQuery();
            List<Map<String,Object>> jobs = new ArrayList<>();
            while (rs.next()) {
                Map<String,Object> m = new HashMap<>();
                m.put("id", rs.getInt("id"));
                m.put("company_name", rs.getString("company_name"));
                m.put("title", rs.getString("title"));
                m.put("description", rs.getString("description"));
                m.put("eligibility", rs.getString("eligibility"));
                m.put("ctc", rs.getString("ctc"));
                m.put("posted_at", rs.getTimestamp("posted_at"));
                jobs.add(m);
            }
            req.setAttribute("jobs", jobs);
            req.getRequestDispatcher("student.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        } finally {
            DBUtil.close(rs, ps, conn);
        }
    }
}