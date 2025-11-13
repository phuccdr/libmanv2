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
import java.sql.Date;
import java.util.List;

/**
 * Servlet xử lý hiển thị danh sách nhập hàng theo nhà cung cấp
 */
@WebServlet(name = "SupplierImportServlet", urlPatterns = {"/manager/statistics/supplier-import"})
public class SupplierImportServlet extends HttpServlet {
    
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
            // Lấy supplierId từ parameter
            String supplierIdStr = request.getParameter("supplierId");
            
            if (supplierIdStr == null || supplierIdStr.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/manager/statistics/supplier");
                return;
            }
            
            int supplierId = Integer.parseInt(supplierIdStr);
            
            // Lấy date range từ session
            Date startDate = (Date) session.getAttribute("startDate");
            Date endDate = (Date) session.getAttribute("endDate");
            
            if (startDate == null || endDate == null) {
                response.sendRedirect(request.getContextPath() + "/manager/statistics/supplier");
                return;
            }
            
            // Gọi InvoiceDAO để lấy danh sách hóa đơn
            List<Invoice> invoices = invoiceDAO.getSupplierImportDocument(supplierId, startDate, endDate);
            
            String supplierName = null;
            if (!invoices.isEmpty()) {
                supplierName = invoices.get(0).getSupplier().getName();
            }
            
            // Set attributes
            request.setAttribute("invoices", invoices);
            request.setAttribute("supplierName", supplierName);
            request.setAttribute("supplierId", supplierId);
            request.setAttribute("startDate", startDate);
            request.setAttribute("endDate", endDate);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/manager/statistics/supplier");
            return;
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
        }
        
        request.getRequestDispatcher("/WEB-INF/views/manager/SupplierImportScreen.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

