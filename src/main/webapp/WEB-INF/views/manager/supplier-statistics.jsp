<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thống kê nhà cung cấp</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📚 LibMan - Quản lý</h1>
            <p>Thống kê nhà cung cấp theo số lượng nhập</p>
        </div>
        
        <div class="nav-bar">
            <div class="nav-links">
                <a href="${pageContext.request.contextPath}/manager/home">Trang chủ</a>
                <a href="${pageContext.request.contextPath}/manager/statistics/choose">Báo cáo thống kê</a>
            </div>
            <div class="user-info">
                <span>Xin chào, ${sessionScope.manager.name}</span>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-secondary">Đăng xuất</a>
            </div>
        </div>
        
        <div class="content">
            <div class="breadcrumb">
                <a href="${pageContext.request.contextPath}/manager/home">Trang chủ</a>
                <span>›</span>
                <a href="${pageContext.request.contextPath}/manager/statistics/choose">Báo cáo thống kê</a>
                <span>›</span>
                <span>Thống kê nhà cung cấp</span>
            </div>
            
            <h2>Thống kê nhà cung cấp</h2>
            
            <c:if test="${not empty errorMessage}">
                <div class="message error">
                    ${errorMessage}
                </div>
            </c:if>
            
            <c:if test="${not empty message}">
                <div class="message warning">
                    ${message}
                </div>
            </c:if>
            
            <div class="card">
                <h3>Chọn khoảng thời gian thống kê</h3>
                
                <form action="${pageContext.request.contextPath}/manager/statistics/supplier" 
                      method="post" class="date-range-form">
                    
                    <div class="form-group">
                        <label for="startDate">Ngày bắt đầu</label>
                        <input type="date" id="startDate" name="startDate" 
                               value="${startDate}" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="endDate">Ngày kết thúc</label>
                        <input type="date" id="endDate" name="endDate" 
                               value="${endDate}" required>
                    </div>
                    
                    <div class="form-group">
                        <label>&nbsp;</label>
                        <button type="submit" class="btn btn-primary">
                            Thống kê
                        </button>
                    </div>
                </form>
            </div>
            
            <c:if test="${not empty statisticsList}">
                <div class="card">
                    <h3>Kết quả thống kê</h3>
                    <p style="color: #666; margin-bottom: 20px;">
                        Từ ngày <strong>${startDate}</strong> đến ngày <strong>${endDate}</strong>
                    </p>
                    
                    <div class="table-container">
                        <table>
                            <thead>
                                <tr>
                                    <th>STT</th>
                                    <th>Mã NCC</th>
                                    <th>Nhà cung cấp</th>
                                    <th style="text-align: right;">Số lượng nhập</th>
                                    <th style="text-align: center;">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="stat" items="${statisticsList}" varStatus="status">
                                    <tr onclick="viewSupplierImport(${stat.supplierId})" 
                                        style="cursor: pointer;">
                                        <td>${status.index + 1}</td>
                                        <td><span style="color: #666;">#${stat.supplierId}</span></td>
                                        <td><strong>${stat.supplierName}</strong></td>
                                        <td style="text-align: right;">
                                            <fmt:formatNumber value="${stat.quantity}" type="number" groupingUsed="true" /> 
                                            <span style="color: #666;">sản phẩm</span>
                                        </td>
                                        <td style="text-align: center;">
                                            <a href="${pageContext.request.contextPath}/manager/statistics/supplier-import?supplierId=${stat.supplierId}" 
                                               class="btn btn-link">
                                                Chi tiết →
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
    
    <script>
        function viewSupplierImport(supplierId) {
            window.location.href = '${pageContext.request.contextPath}/manager/statistics/supplier-import?supplierId=' + supplierId;
        }
        
        // Set default dates if empty
        window.onload = function() {
            const startDate = document.getElementById('startDate');
            const endDate = document.getElementById('endDate');
            
            if (!startDate.value) {
                const today = new Date();
                const firstDay = new Date(today.getFullYear(), today.getMonth(), 1);
                startDate.value = firstDay.toISOString().split('T')[0];
            }
            
            if (!endDate.value) {
                const today = new Date();
                endDate.value = today.toISOString().split('T')[0];
            }
        };
    </script>
</body>
</html>

