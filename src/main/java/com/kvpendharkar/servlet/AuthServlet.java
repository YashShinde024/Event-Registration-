package com.kvpendharkar.servlet;

import java.io.IOException;
import java.sql.SQLException;

import com.kvpendharkar.dao.AdminDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//@WebServlet(urlPatterns = {"/admin/login", "/admin/logout"})
public class AuthServlet extends HttpServlet {
  
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    if (req.getRequestURI().endsWith("/logout")) {
      req.getSession().invalidate();
      resp.sendRedirect(req.getContextPath() + "/admin/login");
      return;
    }
    // show login page
    req.getRequestDispatcher("/login.jsp").forward(req, resp);
  }

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    String username = req.getParameter("username");
    String password = req.getParameter("password");
    try {
      AdminDao adminDao = new AdminDao();
      boolean ok = adminDao.validateCredentials(username, password);
      if (ok) {
        req.getSession(true).setAttribute("adminUser", username);
        resp.sendRedirect(req.getContextPath() + "/admin");
      } else {
        req.setAttribute("error", "Invalid credentials");
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
      }
    } catch (SQLException ex) {
      throw new ServletException(ex);
    }
  }
}
