-- ==============================================================================
-- SANCHAY AI — MySQL Database Schema & Seed Script
-- Database: smart_inventory
-- ==============================================================================

CREATE DATABASE IF NOT EXISTS smart_inventory;
USE smart_inventory;

-- 1. Suppliers Table
CREATE TABLE IF NOT EXISTS suppliers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    contact_email VARCHAR(255) NULL,
    phone VARCHAR(50) NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Products Table
CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    sku VARCHAR(100) NOT NULL UNIQUE,
    supplier_id INT NULL,
    current_stock INT DEFAULT 0,
    min_stock_level INT DEFAULT 10,
    price DECIMAL(10,2) NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT products_ibfk_1 FOREIGN KEY (supplier_id) REFERENCES suppliers (id) ON DELETE SET NULL
);

-- 3. Stock Transactions Table
CREATE TABLE IF NOT EXISTS stock_transactions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    transaction_type ENUM('IN', 'OUT') NOT NULL,
    quantity INT NOT NULL,
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    notes VARCHAR(255) NULL,
    CONSTRAINT stock_transactions_ibfk_1 FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE CASCADE
);

-- ==============================================================================
-- Initial Reference Seed Data
-- ==============================================================================

INSERT IGNORE INTO suppliers (id, name, contact_email, phone) VALUES
(1, 'National Agro Foods', 'agro@nationalfoods.in', '+91 98765 43210'),
(2, 'Kaveri Dairy Cooperative', 'sales@kaveridairy.com', '+91 98220 11223'),
(3, 'Golden Grains Wholesale', 'orders@goldengrains.in', '+91 99100 88776');

INSERT IGNORE INTO products (id, name, sku, supplier_id, current_stock, min_stock_level, price) VALUES
(1, 'Basmati Rice 5kg', 'RIC-BAS-001', 1, 18, 20, 450.00),
(2, 'Sunflower Oil 1L', 'OIL-SUN-002', 1, 35, 15, 140.00),
(3, 'Refined Sugar 1kg', 'SUG-REF-003', 3, 0, 10, 45.00),
(4, 'Wheat Flour (Atta) 10kg', 'FLR-WHT-004', 3, 24, 12, 380.00),
(5, 'Full Cream Milk 500ml', 'DAI-MLK-005', 2, 50, 25, 32.00);

INSERT IGNORE INTO stock_transactions (id, product_id, transaction_type, quantity, transaction_date, notes) VALUES
(101, 1, 'IN', 30, '2026-10-25 10:00:00', 'Initial stocking from National Agro'),
(102, 1, 'OUT', 4, '2026-10-26 14:30:00', 'Retail sale'),
(103, 1, 'OUT', 5, '2026-10-28 16:15:00', 'Retail sale'),
(104, 1, 'OUT', 3, '2026-10-30 11:45:00', 'Bulk purchase order'),
(105, 4, 'OUT', 3, '2026-10-27 17:00:00', 'Retail sale'),
(106, 4, 'OUT', 2, '2026-10-29 13:20:00', 'Retail sale');
