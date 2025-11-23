package com.kvpendharkar.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.kvpendharkar.dao.DbUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/events/delete")   // 👈 URL for delete
public class DeleteEventServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        System.out.println("DeleteEventServlet CALLED, id = " + idParam);

        if (idParam == null || idParam.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/admin/events");
            return;
        }

        try {
            long id = Long.parseLong(idParam);

            try (Connection c = DbUtil.getConnection();
                 PreparedStatement ps = c.prepareStatement(
                         "DELETE FROM events WHERE id = ?")) {

                ps.setLong(1, id);
                int rows = ps.executeUpdate();
                System.out.println("Rows deleted = " + rows);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Always go back to the admin events page
        response.sendRedirect(request.getContextPath() + "/admin/events");
    }
}
