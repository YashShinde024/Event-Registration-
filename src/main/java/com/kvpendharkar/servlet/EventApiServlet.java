package com.kvpendharkar.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.kvpendharkar.dao.EventDao;
import com.kvpendharkar.model.Event;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * REST API for events:
 *  GET /events          -> list all events as JSON
 *  GET /events?id=123   -> single event
 */
public class EventApiServlet extends HttpServlet {

  private final EventDao eventDao = new EventDao();

  // ObjectMapper configured for java.time types (LocalDateTime)
  private final ObjectMapper mapper;

  public EventApiServlet() {
    mapper = new ObjectMapper();
    mapper.registerModule(new JavaTimeModule());
    mapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
  }

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {

    resp.setContentType("application/json;charset=UTF-8");

    String idParam = req.getParameter("id");
    try {
      if (idParam != null && !idParam.isBlank()) {
        long id = Long.parseLong(idParam);
        Optional<Event> evtOpt = eventDao.findById(id);
if (evtOpt.isEmpty()) {
  resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
  mapper.writeValue(resp.getOutputStream(),
      java.util.Map.of("error", "Event not found"));
} else {
  mapper.writeValue(resp.getOutputStream(), evtOpt.get());
}

      } else {
        List<Event> events = eventDao.findAll();
        mapper.writeValue(resp.getOutputStream(), events);
      }
    } catch (SQLException | NumberFormatException ex) {
      ex.printStackTrace();
      resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
      mapper.writeValue(resp.getOutputStream(),
          java.util.Map.of("error", "Server error", "message", ex.getMessage()));
    }
  }
}
