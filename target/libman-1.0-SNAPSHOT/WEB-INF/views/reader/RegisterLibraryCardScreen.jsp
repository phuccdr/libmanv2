<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký thẻ bạn đọc</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📚 LibMan - Bạn đọc</h1>
            <p>Đăng ký thẻ bạn đọc</p>
        </div>
        
        <div class="nav-bar">
            <div class="nav-links">
                <a href="${pageContext.request.contextPath}/reader/home">Trang chủ</a>
                <a href="${pageContext.request.contextPath}/reader/register-card">Đăng ký thẻ bạn đọc</a>
            </div>
            <div class="user-info">
                <span>Xin chào, ${sessionScope.reader.name}</span>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-secondary">Đăng xuất</a>
            </div>
        </div>
        
        <div class="content">
            <div class="breadcrumb">
                <a href="${pageContext.request.contextPath}/reader/home">Trang chủ</a>
                <span>›</span>
                <span>Đăng ký thẻ bạn đọc</span>
            </div>
            
            <h2>Đăng ký thẻ bạn đọc</h2>
            
            <c:if test="${not empty successMessage}">
                <div class="message success">
                    ${successMessage}
                    <div style="margin-top: 15px;">
                        <a href="${pageContext.request.contextPath}/reader/home" class="btn btn-primary">
                            Quay về trang chủ
                        </a>
                    </div>
                </div>
            </c:if>
            
            <c:if test="${not empty errorMessage}">
                <div class="message error">
                    ${errorMessage}
                </div>
            </c:if>
            
            <c:if test="${not empty warningMessage}">
                <div class="message warning">
                    ${warningMessage}
                </div>
            </c:if>
            
            <c:if test="${empty successMessage}">
                <div class="card">
                    <h3>Thông tin đăng ký</h3>
                    
                    <form action="${pageContext.request.contextPath}/reader/register-card" 
                          method="post" enctype="multipart/form-data" id="registerForm">
                        
                        <div class="form-group">
                            <label>Thông tin bạn đọc</label>
                            <div style="background: #f8f9fa; padding: 15px; border-radius: 8px; margin-bottom: 15px;">
                                <p><strong>Họ và tên:</strong> ${sessionScope.reader.name}</p>
                                <p><strong>Email:</strong> 
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.reader.email}">
                                            ${sessionScope.reader.email}
                                        </c:when>
                                        <c:otherwise>Chưa cập nhật</c:otherwise>
                                    </c:choose>
                                </p>
                                <p><strong>Số điện thoại:</strong> 
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.reader.phoneNumber}">
                                            ${sessionScope.reader.phoneNumber}
                                        </c:when>
                                        <c:otherwise>Chưa cập nhật</c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="image">Ảnh thẻ bạn đọc *</label>
                            <div class="file-upload">
                                <input type="file" id="image" name="image" accept="image/*" required 
                                       onchange="previewImage(event)">
                                <label for="image" class="file-upload-label">
                                    📤 Chọn ảnh để upload
                                </label>
                            </div>
                            <small style="color: #666; display: block; margin-top: 5px;">
                                * Chọn ảnh chân dung của bạn (định dạng: JPG, PNG, tối đa 10MB)
                            </small>
                        </div>
                        
                        <div id="imagePreview" style="display: none; margin-bottom: 20px;">
                            <label>Xem trước ảnh:</label>
                            <img id="previewImg" style="max-width: 300px; max-height: 300px; 
                                 border-radius: 8px; border: 2px solid #e0e0e0; display: block; margin-top: 10px;">
                        </div>
                        
                        <div class="form-group">
                            <label for="note">Ghi chú</label>
                            <textarea id="note" name="note" rows="4" 
                                      placeholder="Nhập ghi chú nếu có..."></textarea>
                        </div>
                        
                        <div class="form-group">
                            <label>Thông tin thẻ</label>
                            <div style="background: #f8f9fa; padding: 15px; border-radius: 8px;">
                                <p><strong>Thời hạn:</strong> 1 năm kể từ ngày đăng ký</p>
                                <p><strong>Trạng thái:</strong> Thẻ sẽ được kích hoạt sau khi đăng ký thành công</p>
                            </div>
                        </div>
                        
                        <div style="display: flex; gap: 15px; margin-top: 30px;">
                            <button type="submit" class="btn btn-primary" style="flex: 1;" 
                                    ${hasValidCard ? 'disabled' : ''}>
                                Đăng ký thẻ
                            </button>
                            <a href="${pageContext.request.contextPath}/reader/home" 
                               class="btn btn-secondary" style="flex: 1; text-align: center;">
                                Hủy bỏ
                            </a>
                        </div>
                    </form>
                </div>
            </c:if>
        </div>
    </div>
    
    <script>
        function previewImage(event) {
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('previewImg').src = e.target.result;
                    document.getElementById('imagePreview').style.display = 'block';
                    
                    // Update label text
                    const label = document.querySelector('.file-upload-label');
                    label.textContent = '✅ ' + file.name;
                    label.style.background = 'rgba(40, 167, 69, 0.1)';
                    label.style.borderColor = '#28a745';
                    label.style.color = '#28a745';
                };
                reader.readAsDataURL(file);
            }
        }
    </script>
</body>
</html>

