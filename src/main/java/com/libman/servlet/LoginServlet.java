package com.libman.servlet;

import com.libman.dao.MemberDAO;
import com.libman.model.Member;
import com.libman.model.Reader;
import com.libman.model.Manager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet xử lý đăng nhập
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {
    
    private MemberDAO memberDAO;
    
    @Override
    public void init() throws ServletException {
        memberDAO = new MemberDAO();
    }
    
    /**
     * Hiển thị trang đăng nhập (GET)
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }
    
    /**
     * Xử lý đăng nhập (POST)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Validate input
        if (username == null || username.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Vui lòng nhập đầy đủ thông tin!");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }
        
        // Xác thực người dùng
        Member member = memberDAO.authenticateMember(username, password);
        
        if (member != null) {
            // Kiểm tra loại người dùng
            String memberType = memberDAO.getMemberType(member.getId());
            
            // Lưu vào session
            HttpSession session = request.getSession();
            session.setAttribute("member", member);
            session.setAttribute("memberType", memberType);
            
            if ("READER".equals(memberType)) {
                Reader reader = memberDAO.getReaderByMemberId(member.getId());
                session.setAttribute("reader", reader);
                response.sendRedirect(request.getContextPath() + "/reader/home");
                
            } else if ("MANAGER".equals(memberType)) {
                Manager manager = memberDAO.getManagerByMemberId(member.getId());
                session.setAttribute("manager", manager);
                response.sendRedirect(request.getContextPath() + "/manager/home");
                
            } else {
                request.setAttribute("errorMessage", "Tài khoản không có quyền truy cập!");
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("errorMessage", "Tên đăng nhập hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }
}

