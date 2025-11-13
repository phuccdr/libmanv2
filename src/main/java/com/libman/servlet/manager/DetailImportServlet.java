package com.libman.servlet.manager;

import com.libman.dao.InvoiceDAO;
import com.libman.model.Invoice;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet xử lý hiển thị chi tiết hóa đơn nhập
 */
@WebServlet(name = "DetailImportServlet", urlPatterns = {"/manager/statistics/detail-import"})
public class DetailImportServlet extends HttpServlet {
    
    private InvoiceDAO invoiceDAO;
    
    @Override
    public void init() throws ServletException {
        invoiceDAO = new InvoiceDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Kiểm tra đăng nhập
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("manager") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            // Lấy invoiceId từ parameter
            String invoiceIdStr = request.getParameter("invoiceId");
            
            if (invoiceIdStr == null || invoiceIdStr.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/manager/statistics/supplier");
                return;
            }
            
            int invoiceId = Integer.parseInt(invoiceIdStr);
            
            // Gọi InvoiceDAO để lấy thông tin hóa đơn
            Invoice invoice = invoiceDAO.getInvoiceInfo(invoiceId);
            
            if (invoice == null) {
                request.setAttribute("errorMessage", "Không tìm thấy hóa đơn!");
            }
            
            request.setAttribute("invoice", invoice);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/manager/statistics/supplier");
            return;
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
        }
        
        request.getRequestDispatcher("/WEB-INF/views/manager/DetailImportScreen.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

