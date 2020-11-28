package com.ceritacintaku.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.ceritacintaku.model.Post;
import com.ceritacintaku.model.User;
import com.ceritacintaku.payload.PostRequest;
import com.ceritacintaku.util.DatabaseConnection;

/**
 * PostRepository
 */
public class PostRepository {
  private final String INSERT_POST = "insert into posts (user_id, title, description) values (?, ?, ?)";
  private final String GET_ALL_POSTS = "SELECT * FROM posts";
  private final String UPDATE_POST = "update posts set user_id=?, title=?, description=? where id=?";
  private final String DELETE_POST = "delete from posts where id=?";
  private final String GET_POST = "select * from posts where id=?";
  private final String GET_USER_POSTS = "select * from posts where user_id=?";
  private UserRepository userRepository = new UserRepository();

  public void insertPost(PostRequest post) throws SQLException {
    try (Connection connection = DatabaseConnection.initializeDatabase();
        PreparedStatement preparedStatement = connection.prepareStatement(INSERT_POST)) {
      preparedStatement.setLong(1, post.getUser().getId());
      preparedStatement.setString(2, post.getTitle());
      preparedStatement.setString(3, post.getDescription());
      preparedStatement.executeUpdate();
    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  public boolean updatePost(Post post) throws SQLException {
    boolean isUpdated = false;
    try (Connection connection = DatabaseConnection.initializeDatabase();
        PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_POST)) {
      preparedStatement.setLong(1, post.getUser().getId());
      preparedStatement.setString(2, post.getTitle());
      preparedStatement.setString(3, post.getDescription());
      preparedStatement.setLong(4, post.getId());
      isUpdated = preparedStatement.executeUpdate() > 0;
    } catch (Exception e) {
      e.printStackTrace();
    }
    return isUpdated;
  }

  public boolean deletePost(Long id) throws SQLException {
    boolean isDeleted = false;
    try (Connection connection = DatabaseConnection.initializeDatabase();
        PreparedStatement preparedStatement = connection.prepareStatement(DELETE_POST)) {
      preparedStatement.setLong(1, id);
      isDeleted = preparedStatement.executeUpdate() > 0;
    } catch (Exception e) {
      e.printStackTrace();
    }
    return isDeleted;
  }

  public List<Post> getAllPosts() throws SQLException {
    List<Post> posts = new ArrayList<Post>();
    try (Connection connection = DatabaseConnection.initializeDatabase();
        PreparedStatement preparedStatement = connection.prepareStatement(GET_ALL_POSTS)) {
      ResultSet resultSet = preparedStatement.executeQuery();
      while (resultSet.next()) {
        User user = userRepository.getUserDetail(resultSet.getLong("user_id"));
        Post post = new Post(resultSet.getLong("id"), user, resultSet.getString("title"),
            resultSet.getString("description"));
        posts.add(post);
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
    return posts;
  }

  public Post getPost(Long id) throws SQLException {
    Post post = null;
    try (Connection connection = DatabaseConnection.initializeDatabase();
        PreparedStatement preparedStatement = connection.prepareStatement(GET_POST)) {
      preparedStatement.setLong(1, id);
      ResultSet resultSet = preparedStatement.executeQuery();
      while (resultSet.next()) {
        User user = userRepository.getUserDetail(resultSet.getLong("user_id"));
        post = new Post(resultSet.getLong("id"), user, resultSet.getString("title"),
            resultSet.getString("description"));
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
    return post;
  }

  public List<Post> getUserPosts(Long id) throws SQLException {
    List<Post> posts = new ArrayList<Post>();
    try (Connection connection = DatabaseConnection.initializeDatabase();
        PreparedStatement preparedStatement = connection.prepareStatement(GET_USER_POSTS)) {
      preparedStatement.setLong(1, id);
      ResultSet resultSet = preparedStatement.executeQuery();
      while (resultSet.next()) {
        User user = userRepository.getUserDetail(resultSet.getLong("user_id"));
        Post post = new Post(resultSet.getLong("id"), user, resultSet.getString("title"),
            resultSet.getString("description"));
        posts.add(post);
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
    return posts;
  }
}