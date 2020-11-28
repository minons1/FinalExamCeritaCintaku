package com.ceritacintaku.controller.comment;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ceritacintaku.model.Comment;
import com.ceritacintaku.model.Post;
import com.ceritacintaku.model.User;
import com.ceritacintaku.repository.CommentRepository;
import com.ceritacintaku.repository.PostRepository;
import com.ceritacintaku.util.InputContextValidation;

@WebServlet(name = "UpdateCommentController", urlPatterns = { "/comment/update" })
public class UpdateCommentController extends HttpServlet {
  private static final long serialVersionUID = 1L;
  private CommentRepository commentRepository;
  private PostRepository postRepository;

  public UpdateCommentController() {
    commentRepository = new CommentRepository();
    postRepository = new PostRepository();
  }

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    User user = (User) request.getSession().getAttribute("user");
    Long postId = Long.parseLong(request.getParameter("id"));
    Long commentId = Long.parseLong(request.getParameter("comment_id"));
    try {
      Post post = postRepository.getPost(postId);
      Comment comment = new Comment(commentId, post, user, request.getParameter("description"));
      boolean isValidated = validateInput(request, comment);
      if (isValidated) {
        commentRepository.updateComment(comment);
        String status = "Comment successsfully updated";
        request.getSession().setAttribute("status", status);
        response.sendRedirect(request.getContextPath() + "/post/show.jsp?id=" + postId);
      } else {
        response.sendRedirect(request.getHeader("referer"));
      }
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }

  private boolean validateInput(HttpServletRequest request, Comment comment) {
    boolean checkDescription = InputContextValidation.checkMaximumLength(comment.getDescription(), 200)
        && InputContextValidation.checkMinimumLength(comment.getDescription(), 4);
    if (!checkDescription) {
      String status = "Minimum description length is 4 and maximum length is 50";
      request.getSession().setAttribute("wrong_auth", status);
      return false;
    }
    return true;
  }
}