package com.kvpendharkar.servlet;

import com.kvpendharkar.dao.EventDao;
import com.kvpendharkar.dao.RegistrationDao;
import com.kvpendharkar.model.Registration;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;

@WebServlet(urlPatterns = {"/events/register"})
public class RegisterServlet extends HttpServlet {

  private final RegistrationDao regDao = new RegistrationDao();
  private final EventDao eventDao = new EventDao();
  private final ObjectMapper jackson = new ObjectMapper();

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    resp.setContentType("application/json");

    try {
      Registration r;

      // Accept JSON or form-data
      if (req.getContentType() != null && req.getContentType().toLowerCase().contains("json")) {
        r = jackson.readValue(req.getReader(), Registration.class);
      } else {
        r = new Registration();
        r.setEventId(Long.parseLong(req.getParameter("eventId")));
        r.setName(req.getParameter("name"));
        r.setEmail(req.getParameter("email"));
        r.setPhone(req.getParameter("phone"));

        // ✅ CHANGED: remarks -> studentClass
        r.setStudentClass(req.getParameter("studentClass"));
      }

      // Validation
      if (r.getEventId() == null || r.getName() == null || r.getEmail() == null) {
        resp.setStatus(400);
        resp.getWriter().write("{\"error\":\"Missing required fields\"}");
        return;
      }

      // Check event
      var evOpt = eventDao.findById(r.getEventId());
      if (evOpt.isEmpty()) {
        resp.setStatus(404);
        resp.getWriter().write("{\"error\":\"Event not found\"}");
        return;
      }

      var ev = evOpt.get();
      if (ev.getSeats() != null && ev.getRegisteredCount() != null &&
          ev.getRegisteredCount() >= ev.getSeats()) {
        resp.setStatus(400);
        resp.getWriter().write("{\"error\":\"Event full\"}");
        return;
      }

      // Save
      r.setCreatedAt(LocalDateTime.now());
      regDao.create(r);
      eventDao.incrementRegisteredCount(r.getEventId());

      resp.getWriter().write("{\"status\":\"registered\"}");

    } catch (SQLException ex) {
      resp.setStatus(500);
      resp.getWriter().write("{\"error\":\"" + ex.getMessage() + "\"}");
    }
  }
}
