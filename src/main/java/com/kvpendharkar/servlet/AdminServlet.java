package com.kvpendharkar.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;

import com.kvpendharkar.dao.EventDao;
import com.kvpendharkar.dao.RegistrationDao;
import com.kvpendharkar.model.Event;
import com.kvpendharkar.model.Registration;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AdminServlet extends HttpServlet {

  private boolean isLoggedIn(HttpServletRequest req) {
    return req.getSession(false) != null &&
           req.getSession(false).getAttribute("adminUser") != null;
  }

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {

    if (!isLoggedIn(req)) {
      resp.sendRedirect(req.getContextPath() + "/admin/login");
      return;
    }

    String path = req.getRequestURI();

    try {
      if (path.endsWith("/admin") || path.endsWith("/admin/")) {
        // simple dashboard
        req.getRequestDispatcher("/admin.jsp").forward(req, resp);
        return;
      }

      if (path.endsWith("/admin/registrations")) {
        RegistrationDao regDao = new RegistrationDao();
        List<Registration> regs = regDao.findAll();
        req.setAttribute("registrations", regs);
        req.getRequestDispatcher("/admin.jsp").forward(req, resp);
        return;
      }

      if (path.endsWith("/admin/events")) {
        EventDao eventDao = new EventDao();
        List<Event> events = eventDao.findAll();
        req.setAttribute("events", events);
        req.getRequestDispatcher("/manage-events.jsp").forward(req, resp);
        return;
      }

    } catch (SQLException ex) {
      throw new ServletException(ex);
    }

    resp.sendError(HttpServletResponse.SC_NOT_FOUND);
  }

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {

    if (!isLoggedIn(req)) {
      resp.sendError(HttpServletResponse.SC_FORBIDDEN);
      return;
    }

    String path = req.getRequestURI();

    try {
      // create new event
      if (path.endsWith("/admin/events")) {
        EventDao eventDao = new EventDao();

        Event e = new Event();
        e.setTitle(req.getParameter("title"));
        e.setDescription(req.getParameter("description"));

        String dt = req.getParameter("datetime"); // yyyy-MM-ddTHH:mm
        if (dt != null && !dt.isBlank()) {
          if (dt.length() == 16) dt = dt + ":00"; // add seconds if missing
          e.setDatetime(LocalDateTime.parse(dt.replace(" ", "T")));
        }

        e.setLocation(req.getParameter("location"));
        String seatsStr = req.getParameter("seats");
        if (seatsStr != null && !seatsStr.isBlank()) {
          e.setSeats(Integer.parseInt(seatsStr));
        }

        e.setRegisteredCount(0);
        eventDao.create(e);

        resp.sendRedirect(req.getContextPath() + "/admin/events");
        return;
      }

    } catch (Exception ex) {
      throw new ServletException(ex);
    }

    resp.sendError(HttpServletResponse.SC_NOT_FOUND);
  }
}
