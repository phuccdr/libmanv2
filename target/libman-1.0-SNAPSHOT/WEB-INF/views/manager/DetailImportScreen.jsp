<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết hóa đơn nhập</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📚 LibMan - Quản lý</h1>
            <p>Chi tiết hóa đơn nhập hàng</p>
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
                <span>Chi tiết hóa đơn</span>
            </div>
            
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                <h2>Chi tiết hóa đơn <c:if test="${not empty invoice}">#${invoice.id}</c:if></h2>
                <button onclick="window.history.back()" class="btn btn-secondary">
                    ← Quay lại
                </button>
            </div>
            
            <c:if test="${not empty errorMessage}">
                <div class="message error">
                    ${errorMessage}
                </div>
            </c:if>
            
            <c:if test="${not empty invoice}">
                <!-- Invoice Information Card -->
                <div class="card" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white;">
                    <h3 style="color: white;">Thông tin hóa đơn</h3>
                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 15px; margin-top: 20px;">
                        <div>
                            <strong>Mã hóa đơn:</strong> #${invoice.id}
                        </div>
                        <div>
                            <strong>Ngày nhập:</strong> 
                            <fmt:formatDate value="${invoice.createDate}" pattern="dd/MM/yyyy" />
                        </div>
                        <div>
                            <strong>Người tạo (Quản lý):</strong> ${invoice.managerName}
                        </div>
                        <div>
                            <strong>Người nhập (Nhân viên):</strong> ${invoice.staffName}
                        </div>
                        <div>
                            <strong>Tổng giá trị:</strong> 
                            <fmt:formatNumber value="${invoice.totalPrice}" type="number" groupingUsed="true" /> VNĐ
                        </div>
                    </div>
                </div>
                
                <!-- Import Documents Table -->
                <div class="card">
                    <h3>Danh sách tài liệu nhập</h3>
                    
                    <c:if test="${not empty invoice.documentImports}">
                        <div class="table-container">
                            <table>
                                <thead>
                                    <tr>
                                        <th>STT</th>
                                        <th>Tên tài liệu</th>
                                        <th>Nhà cung cấp</th>
                                        <th style="text-align: center;">Số lượng</th>
                                        <th style="text-align: right;">Đơn giá</th>
                                        <th style="text-align: right;">Thành tiền</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="importDoc" items="${invoice.documentImports}" varStatus="status">
                                        <tr>
                                            <td>${status.index + 1}</td>
                                            <td><strong>${importDoc.documentName}</strong></td>
                                            <td>${importDoc.supplierName}</td>
                                            <td style="text-align: center;">
                                                <span style="background: #667eea; color: white; padding: 5px 12px; 
                                                      border-radius: 20px; font-weight: bold;">
                                                    ${importDoc.quantity}
                                                </span>
                                            </td>
                                            <td style="text-align: right;">
                                                <fmt:formatNumber value="${importDoc.price}" type="number" groupingUsed="true" /> VNĐ
                                            </td>
                                            <td style="text-align: right; font-weight: bold;">
                                                <fmt:formatNumber value="${importDoc.quantity * importDoc.price}" type="number" groupingUsed="true" /> VNĐ
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                                <tfoot style="background: #f8f9fa;">
                                    <tr style="font-weight: bold; font-size: 1.1em;">
                                        <td colspan="5" style="text-align: right; padding: 20px;">
                                            Tổng cộng:
                                        </td>
                                        <td style="text-align: right; color: #667eea; padding: 20px;">
                                            <fmt:formatNumber value="${invoice.totalPrice}" type="number" groupingUsed="true" /> VNĐ
                                        </td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                        
                        <!-- Summary Statistics -->
                        <div class="grid" style="margin-top: 30px;">
                            <div class="stat-card">
                                <h4>Tổng số loại tài liệu</h4>
                                <div class="stat-value">${invoice.documentImports.size()}</div>
                                <p style="opacity: 0.9;">loại tài liệu</p>
                            </div>
                            
                            <div class="stat-card" style="background: linear-gradient(135deg, #28a745 0%, #20c997 100%);">
                                <h4>Tổng số lượng nhập</h4>
                                <div class="stat-value">
                                    <c:set var="totalQty" value="0" />
                                    <c:forEach var="importDoc" items="${invoice.documentImports}">
                                        <c:set var="totalQty" value="${totalQty + importDoc.quantity}" />
                                    </c:forEach>
                                    ${totalQty}
                                </div>
                                <p style="opacity: 0.9;">sản phẩm</p>
                            </div>
                            
                            <div class="stat-card" style="background: linear-gradient(135deg, #ffc107 0%, #ff9800 100%);">
                                <h4>Tổng giá trị</h4>
                                <div class="stat-value">
                                    <fmt:formatNumber value="${invoice.totalPrice}" type="number" groupingUsed="true" />
                                </div>
                                <p style="opacity: 0.9;">VNĐ</p>
                            </div>
                        </div>
                    </c:if>
                    
                    <c:if test="${empty invoice.documentImports}">
                        <div class="empty-state">
                            <h3>Không có dữ liệu</h3>
                            <p>Hóa đơn này chưa có tài liệu nhập nào.</p>
                        </div>
                    </c:if>
                </div>
                
                <!-- Action Buttons -->
                <div style="display: flex; gap: 15px; margin-top: 30px;">
                    <button onclick="window.print()" class="btn btn-primary">
                        🖨️ In hóa đơn
                    </button>
                    <button onclick="window.history.back()" class="btn btn-secondary">
                        ← Quay lại
                    </button>
                </div>
            </c:if>
        </div>
    </div>
    
    <style>
        @media print {
            .nav-bar, .btn, .breadcrumb {
                display: none !important;
            }
            
            body {
                background: white;
            }
            
            .container {
                box-shadow: none;
            }
        }
    </style>
</body>
</html>

