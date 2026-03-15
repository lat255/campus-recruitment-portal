package com.example.portal;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/postJob")
public class PostJobServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession s = req.getSession(false);
        if (s==null || !"recruiter".equals(s.getAttribute("role"))) {
            resp.sendRedirect("login.jsp");
            return;
        }
        int postedBy = (int) s.getAttribute("userId");
        String companyName = req.getParameter("companyName");
        String title = req.getParameter("title");
        String description = req.getParameter("description");
        String eligibility = req.getParameter("eligibility");
        String ctc = req.getParameter("ctc");

        Connection conn=null; PreparedStatement ps=null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement("INSERT INTO jobs (company_name, title, description, eligibility, ctc, posted_by) VALUES (?,?,?,?,?,?)");
            ps.setString(1, companyName);
            ps.setString(2, title);
            ps.setString(3, description);
            ps.setString(4, eligibility);
            ps.setString(5, ctc);
            ps.setInt(6, postedBy);
            ps.executeUpdate();
            resp.sendRedirect("recruiter.jsp");
        } catch (Exception e) {
            throw new ServletException(e);
        } finally {
            DBUtil.close(null, ps, conn);
        }
    }
}