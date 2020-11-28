package com.ceritacintaku.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.ceritacintaku.model.Comment;
import com.ceritacintaku.model.Post;
import com.ceritacintaku.model.User;
import com.ceritacintaku.util.DatabaseConnection;

public class CommentRepository {
  private final String INSERT_COMMENT = "insert into comments (user_id, post_id, description) values (?, ?, ?)";
  private final String UPDATE_COMMENT = "update comments set user_id=?, post_id=?, description=? where id=?";
  private final String DELETE_COMMENT = "delete from comments where id=?";
  private final String GET_COMMENT = "select * from comments where id=?";
  private final String GET_POST_COMMENTS = "select * from comments where post_id=?";
  private UserRepository userRepository = new UserRepository();
  private PostRepository postRepository = new PostRepository();

  public void insertComment(Comment comment) throws SQLException {
    try (Connection connection = DatabaseConnection.initializeDatabase();
        PreparedStatement preparedStatement = connection.prepareStatement(INSERT_COMMENT)) {
      preparedStatement.setLong(1, comment.getUser().getId());
      preparedStatement.setLong(2, comment.getPost().getId());
      preparedStatement.setString(3, comment.getDescription());
      preparedStatement.executeUpdate();
    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  public boolean updateComment(Comment comment) throws SQLException {
    boolean isUpdated = false;
    try (Connection connection = DatabaseConnection.initializeDatabase();
        PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_COMMENT)) {
      preparedStatement.setLong(1, comment.getUser().getId());
      preparedStatement.setLong(2, comment.getPost().getId());
      preparedStatement.setString(3, comment.getDescription());
      preparedStatement.setLong(4, comment.getId());
      isUpdated = preparedStatement.executeUpdate() > 0;
    } catch (Exception e) {
      e.printStackTrace();
    }
    return isUpdated;
  }

  public boolean deleteComment(Long id) throws SQLException {
    boolean isDeleted = false;
    try (Connection connection = DatabaseConnection.initializeDatabase();
        PreparedStatement preparedStatement = connection.prepareStatement(DELETE_COMMENT)) {
      preparedStatement.setLong(1, id);
      isDeleted = preparedStatement.executeUpdate() > 0;
    } catch (Exception e) {
      e.printStackTrace();
    }
    return isDeleted;
  }

  public Comment getComment(Long id) throws SQLException {
    Comment comment = null;
    try (Connection connection = DatabaseConnection.initializeDatabase();
        PreparedStatement preparedStatement = connection.prepareStatement(GET_COMMENT)) {
      preparedStatement.setLong(1, id);
      ResultSet resultSet = preparedStatement.executeQuery();
      while (resultSet.next()) {
        User user = userRepository.getUserDetail(resultSet.getLong("user_id"));
        Post post = postRepository.getPost(resultSet.getLong("post_id"));
        comment = new Comment(resultSet.getLong("id"), post, user, resultSet.getString("description"));
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
    return comment;
  }

  public List<Comment> getPostComments(Long id) throws SQLException {
    List<Comment> comments = new ArrayList<Comment>();
    try (Connection connection = DatabaseConnection.initializeDatabase();
        PreparedStatement preparedStatement = connection.prepareStatement(GET_POST_COMMENTS)) {
      preparedStatement.setLong(1, id);
      ResultSet resultSet = preparedStatement.executeQuery();
      while (resultSet.next()) {
        User user = userRepository.getUserDetail(resultSet.getLong("user_id"));
        Post post = postRepository.getPost(resultSet.getLong("post_id"));
        Comment comment = new Comment(resultSet.getLong("id"), post, user, resultSet.getString("description"));
        comments.add(comment);
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
    return comments;
  }
}