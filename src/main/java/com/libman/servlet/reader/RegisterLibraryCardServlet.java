package com.libman.servlet.reader;

import com.libman.dao.LibraryCardDAO;
import com.libman.model.LibraryCard;
import com.libman.model.Reader;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Date;
import java.time.LocalDate;

/**
 * Servlet xử lý đăng ký thẻ bạn đọc
 */
@WebServlet(name = "RegisterLibraryCardServlet", urlPatterns = {"/reader/register-card"})
@MultipartConfig(
    maxFileSize = 10485760,      // 10MB
    maxRequestSize = 20971520,   // 20MB
    fileSizeThreshold = 1048576  // 1MB
)
public class RegisterLibraryCardServlet extends HttpServlet {
    
    private LibraryCardDAO libraryCardDAO;
    
    @Override
    public void init() throws ServletException {
        libraryCardDAO = new LibraryCardDAO();
    }
    
    /**
     * Hiển thị form đăng ký (GET)
     */
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
        
        request.getRequestDispatcher("/WEB-INF/views/reader/register-card.jsp").forward(request, response);
    }
    
    /**
     * Xử lý đăng ký thẻ (POST)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Kiểm tra đăng nhập
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("reader") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        Reader reader = (Reader) session.getAttribute("reader");
        
        try {
            // Lấy dữ liệu form
            String note = request.getParameter("note");
            Part filePart = request.getPart("image");
            
            // Validate image
            if (filePart == null || filePart.getSize() == 0) {
                request.setAttribute("errorMessage", "Vui lòng upload ảnh thẻ!");
                request.getRequestDispatcher("/WEB-INF/views/reader/register-card.jsp").forward(request, response);
                return;
            }
            
            // Lưu file vào thư mục avatarlibrarycard
            String uploadDir = getServletContext().getRealPath("") + File.separator + "avatarlibrarycard";
            File uploadDirFile = new File(uploadDir);
            if (!uploadDirFile.exists()) {
                uploadDirFile.mkdirs();
            }
            
            String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
            String uniqueFileName = "card_" + reader.getId() + "_" + System.currentTimeMillis() + fileExtension;
            String filePath = uploadDir + File.separator + uniqueFileName;
            
            filePart.write(filePath);
            
            // Tạo đường dẫn tương đối để lưu vào database
            String relativePath = "avatarlibrarycard/" + uniqueFileName;
            
            // Tạo đối tượng LibraryCard
            LibraryCard libraryCard = new LibraryCard();
            libraryCard.setReaderId(reader.getId());
            libraryCard.setNote(note);
            libraryCard.setImage(relativePath);
            
            // Set thời hạn 1 năm
            LocalDate expirationDate = LocalDate.now().plusYears(1);
            libraryCard.setExpirationDate(Date.valueOf(expirationDate));
            
            // Gọi DAO để tạo thẻ
            boolean success = libraryCardDAO.createCard(libraryCard);
            
            if (success) {
                request.setAttribute("successMessage", "Đăng ký thẻ bạn đọc thành công!");
            } else {
                request.setAttribute("errorMessage", "Đăng ký thẻ bạn đọc thất bại. Vui lòng thử lại!");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
        }
        
        request.getRequestDispatcher("/WEB-INF/views/reader/register-card.jsp").forward(request, response);
    }
}

