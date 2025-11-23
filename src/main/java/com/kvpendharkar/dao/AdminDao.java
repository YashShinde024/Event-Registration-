package com.kvpendharkar.dao;

import java.sql.*;

public class AdminDao {

  public boolean validateCredentials(String username, String passwordPlain) throws SQLException {
    try (Connection c = DbUtil.getConnection();
         PreparedStatement ps = c.prepareStatement("SELECT password_hash FROM admin_users WHERE username = ?")) {
      ps.setString(1, username);
      var rs = ps.executeQuery();
      if (rs.next()) {
        String hash = rs.getString(1);
        return org.mindrot.jbcrypt.BCrypt.checkpw(passwordPlain, hash);
      }
    }
    return false;
  }
}
