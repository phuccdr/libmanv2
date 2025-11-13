package com.libman.servlet.reader;

import com.libman.model.Reader;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet hiển thị trang chủ của Reader
 */
@WebServlet(name = "ReaderHomeServlet", urlPatterns = {"/reader/home"})
public class ReaderHomeServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Kiểm tra đăng nhập
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("reader") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        Reader reader = (Reader) session.getAttribute("reader");
        request.setAttribute("reader", reader);
        
        request.getRequestDispatcher("/WEB-INF/views/reader/home.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

