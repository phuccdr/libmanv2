package com.libman.servlet.manager;

import com.libman.model.Manager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet hiển thị trang chủ của Manager
 */
@WebServlet(name = "ManagerHomeServlet", urlPatterns = {"/manager/home"})
public class ManagerHomeServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Kiểm tra đăng nhập
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("manager") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        Manager manager = (Manager) session.getAttribute("manager");
        request.setAttribute("manager", manager);
        
        request.getRequestDispatcher("/WEB-INF/views/manager/home.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

