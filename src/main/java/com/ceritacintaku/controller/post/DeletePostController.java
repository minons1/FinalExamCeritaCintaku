package com.ceritacintaku.controller.post;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ceritacintaku.model.Post;
import com.ceritacintaku.model.User;
import com.ceritacintaku.payload.PostRequest;
import com.ceritacintaku.repository.PostRepository;

@WebServlet(name = "DeletePostController", urlPatterns = { "/post/delete" })
public class DeletePostController extends HttpServlet {
  private static final long serialVersionUID = 1L;
  private PostRepository postRepository;

  public DeletePostController() {
    postRepository = new PostRepository();
  }

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    User user = (User) request.getSession().getAttribute("user");
    Post post;
    try {
      post = postRepository.getPost(Long.parseLong(request.getParameter("id")));
      var isValidated = validateUser(user, post.getUser());
      if (isValidated) {
        postRepository.deletePost(post.getId());
        String status = "Post successsfully deleted";
        request.getSession().setAttribute("status", status);
        response.sendRedirect(request.getContextPath() + "/post/index.jsp");
      } else {
        String status = "Post can't deleted";
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
