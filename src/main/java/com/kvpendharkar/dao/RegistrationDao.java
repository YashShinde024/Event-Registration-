package com.kvpendharkar.dao;

import com.kvpendharkar.model.Registration;
import java.sql.*;
import java.util.*;

public class RegistrationDao {

  public void create(Registration r) throws SQLException {
    try (Connection c = DbUtil.getConnection();
         PreparedStatement ps = c.prepareStatement(
           "INSERT INTO registrations (event_id, name, email, phone, student_class, created_at) VALUES (?,?,?,?,?,?)",
           Statement.RETURN_GENERATED_KEYS)) {

      ps.setLong(1, r.getEventId());
      ps.setString(2, r.getName());
      ps.setString(3, r.getEmail());
      ps.setString(4, r.getPhone());
      ps.setString(5, r.getStudentClass());   // changed from getRemarks()
      ps.setTimestamp(6, Timestamp.valueOf(r.getCreatedAt()));

      ps.executeUpdate();
      try (ResultSet rs = ps.getGeneratedKeys()) {
        if (rs.next()) {
          r.setId(rs.getLong(1));
        }
      }
    }
  }

  public List<Registration> findAll() throws SQLException {
    List<Registration> list = new ArrayList<>();
    try (Connection c = DbUtil.getConnection();
         PreparedStatement ps = c.prepareStatement(
           "SELECT * FROM registrations ORDER BY created_at DESC")) {
      try (ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
          list.add(map(rs));
        }
      }
    }
    return list;
  }

  public List<Registration> findByEventId(long eventId) throws SQLException {
    List<Registration> list = new ArrayList<>();
    try (Connection c = DbUtil.getConnection();
         PreparedStatement ps = c.prepareStatement(
           "SELECT * FROM registrations WHERE event_id = ? ORDER BY created_at DESC")) {

      ps.setLong(1, eventId);
      try (ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
          list.add(map(rs));
        }
      }
    }
    return list;
  }

  private Registration map(ResultSet rs) throws SQLException {
    Registration r = new Registration();
    r.setId(rs.getLong("id"));
    r.setEventId(rs.getLong("event_id"));
    r.setName(rs.getString("name"));
    r.setEmail(rs.getString("email"));
    r.setPhone(rs.getString("phone"));

    // changed from "remarks"
    r.setStudentClass(rs.getString("student_class"));

    Timestamp t = rs.getTimestamp("created_at");
    if (t != null) {
      r.setCreatedAt(t.toLocalDateTime());
    }
    return r;
  }
}
