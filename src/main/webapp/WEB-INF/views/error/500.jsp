<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>500 - Lỗi hệ thống</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container login-container">
        <div class="header">
            <h1>📚 LibMan</h1>
            <p>Hệ thống quản lý thư viện</p>
        </div>
        
        <div class="login-form">
            <h2>500 - Lỗi hệ thống</h2>
            <div class="message error">
                Đã có lỗi xảy ra trong quá trình xử lý. Vui lòng thử lại sau.
            </div>
            <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">
                Quay về trang đăng nhập
            </a>
        </div>
    </div>
</body>
</html>

