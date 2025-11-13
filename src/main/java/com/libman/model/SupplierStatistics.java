package com.libman.model;

/**
 * SupplierStatistics model for supplier import statistics
 * Kế thừa từ Supplier và thêm thông tin thống kê
 */
public class SupplierStatistics extends Supplier {
    private int quantity;
 
    // Constructors
    public SupplierStatistics() {
        super();
    }
    
    public SupplierStatistics(int supplierId, String supplierName, int quantity) {
        super();
        this.setId(supplierId);
        this.setName(supplierName);
        this.quantity = quantity;
    }
    
    public SupplierStatistics(String name, String phoneNumber, String email, String address, int quantity) {
        super(name, phoneNumber, email, address);
        this.quantity = quantity;
    }
    
    // Getters and Setters cho quantity
    public int getQuantity() {
        return quantity;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    // Convenience methods để tương thích với code cũ
    public int getSupplierId() {
        return getId();
    }
    
    public void setSupplierId(int supplierId) {
        setId(supplierId);
    }
    
    public String getSupplierName() {
        return getName();
    }
    
    public void setSupplierName(String supplierName) {
        setName(supplierName);
    }
}









