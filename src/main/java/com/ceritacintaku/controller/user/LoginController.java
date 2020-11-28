package com.ceritacintaku.controller.user;

import java.io.IOException;
import java.sql.SQLException;

import com.ceritacintaku.model.User;
import com.ceritacintaku.payload.UserLoginRequest;
import com.ceritacintaku.repository.UserRepository;
import com.ceritacintaku.util.InputContextValidation;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LoginController", urlPatterns = { "/login" })
public class LoginController extends HttpServlet {
  private static final long serialVersionUID = 1L;

  private UserRepository userRepository;

  public LoginController() {
    this.userRepository = new UserRepository();
  }

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    UserLoginRequest userLoginRequest = new UserLoginRequest(request.getParameter("email"),
        InputContextValidation.convertToMD5(request.getParameter("password")));
    try {
      User user = userRepository.login(userLoginRequest);
      if (user != null) {
        HttpSession session = request.getSession();
        session.setAttribute("user", user);
        response.sendRedirect(request.getContextPath() + "/post/index.jsp");
      } else {
        String status = "Wrong email/password";
        request.getSession().setAttribute("wrong_auth", status);
        response.sendRedirect(request.getContextPath() + "/login.jsp");
      }
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }
}
