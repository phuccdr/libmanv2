<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết nhập hàng - Nhà cung cấp</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📚 LibMan - Quản lý</h1>
            <p>Chi tiết nhập hàng từ nhà cung cấp</p>
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
                <a href="${pageContext.request.contextPath}/manager/statistics/supplier">Thống kê nhà cung cấp</a>
                <span>›</span>
                <span>Chi tiết nhập hàng</span>
            </div>
            
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                <h2>Chi tiết nhập hàng - ${supplierName}</h2>
                <a href="${pageContext.request.contextPath}/manager/statistics/supplier" 
                   class="btn btn-secondary">
                    ← Quay lại
                </a>
            </div>
            
            <c:if test="${not empty errorMessage}">
                <div class="message error">
                    ${errorMessage}
                </div>
            </c:if>
            
            <c:if test="${not empty invoices}">
                <div class="card">
                    <h3>Danh sách hóa đơn nhập hàng</h3>
                    <p style="color: #666; margin-bottom: 20px;">
                        Từ ngày <strong><fmt:formatDate value="${startDate}" pattern="dd/MM/yyyy" /></strong> 
                        đến ngày <strong><fmt:formatDate value="${endDate}" pattern="dd/MM/yyyy" /></strong>
                    </p>
                    
                    <div class="table-container">
                        <table>
                            <thead>
                                <tr>
                                    <th>STT</th>
                                    <th>Mã hóa đơn</th>
                                    <th>Ngày nhập</th>
                                    <th>Người tạo</th>
                                    <th>Người nhập</th>
                                    <th style="text-align: right;">Tổng giá trị</th>
                                    <th style="text-align: center;">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:set var="totalSum" value="0" />
                                <c:forEach var="invoice" items="${invoices}" varStatus="status">
                                    <tr onclick="viewInvoiceDetail(${invoice.id})" 
                                        style="cursor: pointer;">
                                        <td>${status.index + 1}</td>
                                        <td><strong>#${invoice.id}</strong></td>
                                        <td>
                                            <fmt:formatDate value="${invoice.createDate}" pattern="dd/MM/yyyy" />
                                        </td>
                                        <td>${invoice.managerName}</td>
                                        <td>${invoice.staffName}</td>
                                        <td style="text-align: right;">
                                            <fmt:formatNumber value="${invoice.totalPrice}" type="number" groupingUsed="true" /> 
                                            <span style="color: #666;">VNĐ</span>
                                        </td>
                                        <td style="text-align: center;">
                                            <a href="${pageContext.request.contextPath}/manager/statistics/detail-import?invoiceId=${invoice.id}" 
                                               class="btn btn-link">
                                                Xem chi tiết →
                                            </a>
                                        </td>
                                    </tr>
                                    <c:set var="totalSum" value="${totalSum + invoice.totalPrice}" />
                                </c:forEach>
                            </tbody>
                            <tfoot style="background: #f8f9fa; font-weight: bold;">
                                <tr>
                                    <td colspan="5" style="text-align: right;">Tổng cộng:</td>
                                    <td style="text-align: right;">
                                        <fmt:formatNumber value="${totalSum}" type="number" groupingUsed="true" /> 
                                        <span style="color: #666;">VNĐ</span>
                                    </td>
                                    <td></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </c:if>
            
            <c:if test="${empty invoices and empty errorMessage}">
                <div class="empty-state">
                    <h3>Không có dữ liệu</h3>
                    <p>Không tìm thấy hóa đơn nhập hàng nào từ nhà cung cấp này trong khoảng thời gian đã chọn.</p>
                </div>
            </c:if>
        </div>
    </div>
    
    <script>
        function viewInvoiceDetail(invoiceId) {
            window.location.href = '${pageContext.request.contextPath}/manager/statistics/detail-import?invoiceId=' + invoiceId;
        }
    </script>
</body>
</html>

