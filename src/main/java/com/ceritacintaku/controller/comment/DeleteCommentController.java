package com.ceritacintaku.controller.comment;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ceritacintaku.model.Comment;
import com.ceritacintaku.model.User;
import com.ceritacintaku.repository.CommentRepository;

@WebServlet(name = "DeleteCommentController", urlPatterns = { "/post/comment/delete" })
public class DeleteCommentController extends HttpServlet {
  private static final long serialVersionUID = 1L;
  private CommentRepository commentRepository;

  public DeleteCommentController() {
    commentRepository = new CommentRepository();
  }

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    User user = (User) request.getSession().getAttribute("user");
    Comment comment;
    try {
      comment = commentRepository.getComment(Long.parseLong(request.getParameter("comment_id")));
      var isValidated = validateUser(user, comment.getUser());
      if (isValidated) {
        commentRepository.deleteComment(comment.getId());
        String status = "Comment successsfully deleted";
        request.getSession().setAttribute("status", status);
        response.sendRedirect((request.getHeader("referer")));
      } else {
        String status = "Comment can't deleted";
        request.getSession().setAttribute("wrong_auth", status);
        response.sendRedirect(request.getHeader("referer"));
      }
    } catch (NumberFormatException e1) {
      // TODO Auto-generated catch block
      e1.printStackTrace();
    } catch (SQLException e1) {
      // TODO Auto-generated catch block
      e1.printStackTrace();
    }
  }

  private boolean validateUser(User user, User userPost) {
    return user.getId() == userPost.getId();
  }
}
