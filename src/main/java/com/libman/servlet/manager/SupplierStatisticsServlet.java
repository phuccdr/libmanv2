package com.libman.servlet.manager;

import com.libman.dao.SupplierStatisticsDAO;
import com.libman.model.SupplierStatistics;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

/**
 * Servlet xử lý thống kê nhà cung cấp
 */
@WebServlet(name = "SupplierStatisticsServlet", urlPatterns = {"/manager/statistics/supplier"})
public class SupplierStatisticsServlet extends HttpServlet {
    
    private SupplierStatisticsDAO statisticsDAO;
    
    @Override
    public void init() throws ServletException {
        statisticsDAO = new SupplierStatisticsDAO();
    }
    
    /**
     * Hiển thị form thống kê (GET)
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Kiểm tra đăng nhập
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("manager") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        request.getRequestDispatcher("/WEB-INF/views/manager/SupplierStatisticsScreen.jsp").forward(request, response);
    }
    
    /**
     * Xử lý form thống kê (POST)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Kiểm tra đăng nhập
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("manager") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");
        
        try {
            // Validate dates
            if (startDateStr == null || startDateStr.isEmpty() || 
                endDateStr == null || endDateStr.isEmpty()) {
                request.setAttribute("errorMessage", "Vui lòng nhập đầy đủ ngày bắt đầu và ngày kết thúc!");
            } else {
                Date startDate = Date.valueOf(startDateStr);
                Date endDate = Date.valueOf(endDateStr);
                
                // Validate date range
                if (startDate.after(endDate)) {
                    request.setAttribute("errorMessage", "Ngày bắt đầu phải trước ngày kết thúc!");
                } else {
                    // Gọi DAO để generate thống kê
                    List<SupplierStatistics> statisticsList = statisticsDAO.generateStatistics(startDate, endDate);
                    
                    // Lưu vào session để dùng ở các trang khác
                    session.setAttribute("startDate", startDate);
                    session.setAttribute("endDate", endDate);
                    
                    // Set attributes cho view
                    request.setAttribute("statisticsList", statisticsList);
                    request.setAttribute("startDate", startDateStr);
                    request.setAttribute("endDate", endDateStr);
                    
                    if (statisticsList.isEmpty()) {
                        request.setAttribute("message", "Không có dữ liệu thống kê trong khoảng thời gian này!");
                    }
                }
            }
        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", "Định dạng ngày không hợp lệ!");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
        }
        
        // Giữ lại giá trị đã nhập
        request.setAttribute("startDate", startDateStr);
        request.setAttribute("endDate", endDateStr);
        
        request.getRequestDispatcher("/WEB-INF/views/manager/SupplierStatisticsScreen.jsp").forward(request, response);
    }
}

