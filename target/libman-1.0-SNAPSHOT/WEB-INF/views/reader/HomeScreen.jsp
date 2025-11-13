<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ - Bạn đọc</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📚 LibMan - Bạn đọc</h1>
            <p>Hệ thống quản lý thư viện</p>
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
            <h2>Chào mừng bạn đến với hệ thống quản lý thư viện!</h2>
            
            <div class="grid">
                <div class="card">
                    <h3>📋 Đăng ký thẻ bạn đọc</h3>
                    <p>Đăng ký thẻ bạn đọc để có thể mượn sách và tài liệu từ thư viện.</p>
                    <a href="${pageContext.request.contextPath}/reader/register-card" 
                       class="btn btn-primary" style="margin-top: 15px;">
                        Đăng ký ngay
                    </a>
                </div>
                
                <div class="card">
                    <h3>📚 Mượn sách</h3>
                    <p>Xem danh sách sách có sẵn và tạo phiếu mượn sách từ thư viện.</p>
                    <button class="btn btn-primary" style="margin-top: 15px;" disabled>
                        Sắp ra mắt
                    </button>
                </div>
                
                <div class="card">
                    <h3>↩️ Trả sách</h3>
                    <p>Quản lý và trả sách đã mượn từ thư viện.</p>
                    <button class="btn btn-primary" style="margin-top: 15px;" disabled>
                        Sắp ra mắt
                    </button>
                </div>
                
                <div class="card">
                    <h3>👤 Thông tin cá nhân</h3>
                    <p>Xem và cập nhật thông tin cá nhân của bạn.</p>
                    <button class="btn btn-primary" style="margin-top: 15px;" disabled>
                        Sắp ra mắt
                    </button>
                </div>
            </div>
            
            <div class="card" style="margin-top: 30px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white;">
                <h3 style="color: white;">Thông tin bạn đọc</h3>
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 15px; margin-top: 20px;">
                    <div>
                        <strong>Tên đăng nhập:</strong> ${sessionScope.reader.username}
                    </div>
                    <div>
                        <strong>Họ và tên:</strong> ${sessionScope.reader.name}
                    </div>
                    <div>
                        <strong>Email:</strong> 
                        <c:choose>
                            <c:when test="${not empty sessionScope.reader.email}">
                                ${sessionScope.reader.email}
                            </c:when>
                            <c:otherwise>Chưa cập nhật</c:otherwise>
                        </c:choose>
                    </div>
                    <div>
                        <strong>Số điện thoại:</strong> 
                        <c:choose>
                            <c:when test="${not empty sessionScope.reader.phoneNumber}">
                                ${sessionScope.reader.phoneNumber}
                            </c:when>
                            <c:otherwise>Chưa cập nhật</c:otherwise>
                        </c:choose>
                    </div>
                    <div>
                        <strong>Địa chỉ:</strong> 
                        <c:choose>
                            <c:when test="${not empty sessionScope.reader.address}">
                                ${sessionScope.reader.address}
                            </c:when>
                            <c:otherwise>Chưa cập nhật</c:otherwise>
                        </c:choose>
                    </div>
                    <div>
                        <strong>Xếp hạng:</strong> ⭐ ${sessionScope.reader.rating}/5
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

