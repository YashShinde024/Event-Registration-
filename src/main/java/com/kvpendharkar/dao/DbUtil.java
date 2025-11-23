package com.kvpendharkar.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

public class DbUtil {
  private static final String URL = "jdbc:h2:file:./data/eventdb;AUTO_SERVER=TRUE";
  private static final String USER = "sa";
  private static final String PASS = "";

  static {
    try {
      Class.forName("org.h2.Driver");
      initSchema();
    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  public static Connection getConnection() throws SQLException {
    return DriverManager.getConnection(URL, USER, PASS);
  }

  // create tables if not exists
  private static void initSchema() {
    try (Connection c = getConnection();
         Statement s = c.createStatement()) {

      s.executeUpdate("""
        CREATE TABLE IF NOT EXISTS events (
          id IDENTITY PRIMARY KEY,
          title VARCHAR(255),
          description CLOB,
          datetime TIMESTAMP,
          location VARCHAR(255),
          seats INTEGER,
          registered_count INTEGER DEFAULT 0
        );
      """);

      s.executeUpdate("""
        CREATE TABLE IF NOT EXISTS registrations (
          id IDENTITY PRIMARY KEY,
          event_id BIGINT,
          name VARCHAR(255),
          email VARCHAR(255),
          phone VARCHAR(100),
          remarks CLOB,
          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        );
      """);

      s.executeUpdate("""
        CREATE TABLE IF NOT EXISTS admin_users (
          id IDENTITY PRIMARY KEY,
          username VARCHAR(100) UNIQUE,
          password_hash VARCHAR(255)
        );
      """);

      // create default admin if not exists
      try (PreparedStatement ps = c.prepareStatement("SELECT COUNT(*) FROM admin_users WHERE username = ?")) {
        ps.setString(1, "admin");
        var rs = ps.executeQuery();
        if (rs.next() && rs.getInt(1) == 0) {
          // Use jBCrypt to hash password
          String hash = org.mindrot.jbcrypt.BCrypt.hashpw("admin123", org.mindrot.jbcrypt.BCrypt.gensalt());
          try (PreparedStatement ins = c.prepareStatement("INSERT INTO admin_users (username,password_hash) VALUES (?,?)")) {
            ins.setString(1, "admin");
            ins.setString(2, hash);
            ins.executeUpdate();
            System.out.println("Created default admin -> admin / admin123");
          }
        }
      }

      // Insert sample events if none exist - deleted

    } catch (SQLException ex) {
      ex.printStackTrace();
    }
  }
}
