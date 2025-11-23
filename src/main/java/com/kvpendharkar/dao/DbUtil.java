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

      // CHANGED: remarks -> student_class
      s.executeUpdate("""
        CREATE TABLE IF NOT EXISTS registrations (
          id IDENTITY PRIMARY KEY,
          event_id BIGINT,
          name VARCHAR(255),
          email VARCHAR(255),
          phone VARCHAR(100),
          student_class VARCHAR(255),
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
      try (PreparedStatement ps = c.prepareStatement(
              "SELECT COUNT(*) FROM admin_users WHERE username = ?")) {
        ps.setString(1, "admin");
        var rs = ps.executeQuery();
        if (rs.next() && rs.getInt(1) == 0) {
          String hash = org.mindrot.jbcrypt.BCrypt.hashpw(
              "admin123", org.mindrot.jbcrypt.BCrypt.gensalt());
          try (PreparedStatement ins = c.prepareStatement(
                  "INSERT INTO admin_users (username,password_hash) VALUES (?,?)")) {
            ins.setString(1, "admin");
            ins.setString(2, hash);
            ins.executeUpdate();
            System.out.println("Created default admin -> admin / admin123");
          }
        }
      }

      // --- MIGRATION FROM OLD 'remarks' COLUMN TO 'student_class' ---
      try (Statement mig = c.createStatement()) {
        // 1) Try to add student_class if DB was created with old schema
        try {
          mig.executeUpdate("ALTER TABLE registrations ADD COLUMN student_class VARCHAR(255)");
        } catch (SQLException ignore) {
          // column already exists -> ignore
        }

        // 2) Copy data from remarks -> student_class if both exist
        try {
          mig.executeUpdate(
              "UPDATE registrations " +
              "SET student_class = remarks " +
              "WHERE student_class IS NULL AND remarks IS NOT NULL"
          );
        } catch (SQLException ignore) {
          // if old 'remarks' column doesn't exist in this DB, ignore
        }
      }


    } catch (SQLException ex) {
      ex.printStackTrace();
    }
  }
}
