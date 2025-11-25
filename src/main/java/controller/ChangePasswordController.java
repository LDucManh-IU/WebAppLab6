package controller;

import dao.UserDAO;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/change-password")
public class ChangePasswordController extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/change-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Basic validation
        if (currentPassword == null || newPassword == null || confirmPassword == null ||
                currentPassword.trim().isEmpty() || newPassword.trim().isEmpty() || confirmPassword.trim().isEmpty()) {

            request.setAttribute("error", "All fields are required");
            request.getRequestDispatcher("/views/change-password.jsp").forward(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "New password and confirmation do not match");
            request.getRequestDispatcher("/views/change-password.jsp").forward(request, response);
            return;
        }

        if (newPassword.length() < 6) {
            request.setAttribute("error", "New password must be at least 6 characters long");
            request.getRequestDispatcher("/views/change-password.jsp").forward(request, response);
            return;
        }

        // Get current user from session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User sessionUser = (User) session.getAttribute("user");

        // Verify current password
        User freshUser = userDAO.getUserById(sessionUser.getId());
        if (freshUser == null) {
            request.setAttribute("error", "User not found");
            request.getRequestDispatcher("/views/change-password.jsp").forward(request, response);
            return;
        }

        // BCrypt check (password in freshUser is hashed)
        if (!org.mindrot.jbcrypt.BCrypt.checkpw(currentPassword, freshUser.getPassword())) {
            request.setAttribute("error", "Current password is incorrect");
            request.getRequestDispatcher("/views/change-password.jsp").forward(request, response);
            return;
        }

        // Perform update
        boolean updated = userDAO.updatePassword(freshUser.getId(), newPassword);
        if (updated) {
            // Refresh session user info
            User updatedUser = userDAO.getUserById(freshUser.getId());
            session.setAttribute("user", updatedUser);
            request.setAttribute("success", "Password changed successfully");
        } else {
            request.setAttribute("error", "Failed to change password. Please try again later.");
        }

        request.getRequestDispatcher("/views/change-password.jsp").forward(request, response);
    }
}
