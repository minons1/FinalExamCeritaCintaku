package com.ceritacintaku.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.ceritacintaku.model.User;
import com.ceritacintaku.payload.UserLoginRequest;
import com.ceritacintaku.payload.UserRegisterRequest;
import com.ceritacintaku.util.DatabaseConnection;

public class UserRepository {
  private final String INSERT_SQL = "insert into users (name, email, password) values (?, ?, ?)";
  private final String CHECK_EMAIL_USER = "SELECT * from  users where email=? limit 1";
  private final String GET_BY_USER_ID = "select * from users where id=?";

  public void insertUser(UserRegisterRequest user) throws SQLException {
    try (Connection connection = DatabaseConnection.initializeDatabase();
        PreparedStatement preparedStatement = connection.prepareStatement(INSERT_SQL)) {
      preparedStatement.setString(1, user.getName());
      preparedStatement.setString(2, user.getEmail());
      preparedStatement.setString(3, user.getPassword());
      preparedStatement.executeUpdate();
    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  public boolean checkEmailExist(String email) throws SQLException {
    boolean isEmailExist = true;
    try (Connection connection = DatabaseConnection.initializeDatabase();
        PreparedStatement preparedStatement = connection.prepareStatement(CHECK_EMAIL_USER)) {
      preparedStatement.setString(1, email);
      ResultSet resultQuery = preparedStatement.executeQuery();
      if (resultQuery.next()) {
        isEmailExist = true;
      } else {
        isEmailExist = false;
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
    return isEmailExist;
  }

  public User login(UserLoginRequest userRequest) throws SQLException {
    User user = null;
    var password = "";
    try (Connection connection = DatabaseConnection.initializeDatabase();
        PreparedStatement preparedStatement = connection.prepareStatement(CHECK_EMAIL_USER)) {
      preparedStatement.setString(1, userRequest.getEmail());
      ResultSet resultQuery = preparedStatement.executeQuery();
      while (resultQuery.next()) {
        password = resultQuery.getString("password");
        user = new User(resultQuery.getLong("id"), resultQuery.getString("name"), resultQuery.getString("email"), "");
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
    return password.compareTo(userRequest.getPassword()) == 0 ? user : null;
  }

  public User getUserDetail(Long id) throws SQLException {
    User user = null;
    try (Connection connection = DatabaseConnection.initializeDatabase();
        PreparedStatement preparedStatement = connection.prepareStatement(GET_BY_USER_ID)) {
      preparedStatement.setLong(1, id);
      ResultSet resultQuery = preparedStatement.executeQuery();
      while (resultQuery.next()) {
        user = new User(resultQuery.getLong("id"), resultQuery.getString("name"), resultQuery.getString("email"),
            resultQuery.getString("password"));
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
    return user;
  }
}