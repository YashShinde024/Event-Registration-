package com.kvpendharkar.dao;

import com.kvpendharkar.model.Event;
import java.sql.*;
import java.util.*;

public class EventDao {

  public List<Event> findAll() throws SQLException {
    List<Event> list = new ArrayList<>();
    try (Connection c = DbUtil.getConnection();
         PreparedStatement ps = c.prepareStatement("SELECT * FROM events ORDER BY datetime")) {
      var rs = ps.executeQuery();
      while (rs.next()) list.add(map(rs));
    }
    return list;
  }

  public Optional<Event> findById(long id) throws SQLException {
    try (Connection c = DbUtil.getConnection();
         PreparedStatement ps = c.prepareStatement("SELECT * FROM events WHERE id = ?")) {
      ps.setLong(1, id);
      var rs = ps.executeQuery();
      if (rs.next()) return Optional.of(map(rs));
    }
    return Optional.empty();
  }

  public Event create(Event e) throws SQLException {
    try (Connection c = DbUtil.getConnection();
         PreparedStatement ps = c.prepareStatement(
             "INSERT INTO events (title,description,datetime,location,seats,registered_count) VALUES (?,?,?,?,?,?)",
             Statement.RETURN_GENERATED_KEYS)) {
      ps.setString(1, e.getTitle());
      ps.setString(2, e.getDescription());
      ps.setTimestamp(3, Timestamp.valueOf(e.getDatetime()));
      ps.setString(4, e.getLocation());
      if (e.getSeats() != null) ps.setInt(5, e.getSeats()); else ps.setNull(5, Types.INTEGER);
      ps.setInt(6, e.getRegisteredCount() == null ? 0 : e.getRegisteredCount());
      ps.executeUpdate();
      var rs = ps.getGeneratedKeys();
      if (rs.next()) e.setId(rs.getLong(1));
    }
    return e;
  }

  public void incrementRegisteredCount(long eventId) throws SQLException {
    try (Connection c = DbUtil.getConnection();
         PreparedStatement ps = c.prepareStatement("UPDATE events SET registered_count = COALESCE(registered_count,0) + 1 WHERE id = ?")) {
      ps.setLong(1, eventId);
      ps.executeUpdate();
    }
  }

  private Event map(ResultSet rs) throws SQLException {
    Event e = new Event();
    e.setId(rs.getLong("id"));
    e.setTitle(rs.getString("title"));
    e.setDescription(rs.getString("description"));
    Timestamp t = rs.getTimestamp("datetime");
    if (t != null) e.setDatetime(t.toLocalDateTime());
    e.setLocation(rs.getString("location"));
    int seats = rs.getInt("seats");
    if (!rs.wasNull()) e.setSeats(seats);
    int rc = rs.getInt("registered_count");
    if (!rs.wasNull()) e.setRegisteredCount(rc);
    return e;
  }
}
