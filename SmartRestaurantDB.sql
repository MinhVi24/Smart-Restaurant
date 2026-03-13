-- =============================================
-- Smart Restaurant Database - FINAL SETUP
-- Chỉ cần chạy file này 1 lần duy nhất
-- =============================================

USE master;
GO

-- Create database if not exists
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'SmartRestaurantDB')
    CREATE DATABASE SmartRestaurantDB;
GO

USE SmartRestaurantDB;
GO

PRINT '========================================';
PRINT 'SMART RESTAURANT DATABASE SETUP';
PRINT '========================================';
PRINT '';

-- =============================================
-- 1. CREATE TABLES
-- =============================================

-- Users
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Users')
CREATE TABLE Users (
    user_id INT IDENTITY PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    email VARCHAR(100),
    role VARCHAR(20) NOT NULL CHECK (role IN ('CUSTOMER', 'STAFF', 'ADMIN')),
    status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE' CHECK (status IN ('ACTIVE', 'INACTIVE', 'BANNED')),
    created_at DATETIME NOT NULL DEFAULT GETDATE()
);
GO

-- Customers
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Customers')
CREATE TABLE Customers (
    customer_id INT IDENTITY PRIMARY KEY,
    user_id INT UNIQUE NOT NULL,
    full_name NVARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    membership_level VARCHAR(20) DEFAULT 'Regular',
    total_points INT DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
GO

-- Staff
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Staff')
CREATE TABLE Staff (
    staff_id INT IDENTITY PRIMARY KEY,
    user_id INT UNIQUE NOT NULL,
    full_name NVARCHAR(100) NOT NULL,
    position VARCHAR(30),
    status VARCHAR(20) DEFAULT 'ACTIVE' CHECK (status IN ('ACTIVE','OFF','RESIGNED')),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
GO

-- Tables
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Tables')
CREATE TABLE Tables (
    table_id INT IDENTITY PRIMARY KEY,
    area NVARCHAR(50),
    capacity INT NOT NULL CHECK (capacity > 0),
    status VARCHAR(20) DEFAULT 'AVAILABLE' CHECK (status IN ('AVAILABLE','OCCUPIED','RESERVED'))
);
GO

-- Menu_Items
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Menu_Items')
CREATE TABLE Menu_Items (
    menu_item_id INT IDENTITY PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'AVAILABLE',
    description NVARCHAR(500) NULL,
    category NVARCHAR(50) NULL,
    image_url NVARCHAR(500) NULL,
    options NVARCHAR(MAX) NULL
);
GO

-- Reservations
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Reservations')
CREATE TABLE Reservations (
    reservation_id INT IDENTITY PRIMARY KEY,
    customer_id INT NOT NULL,
    table_id INT NULL,
    reservation_time DATETIME NOT NULL,
    guest_count INT NOT NULL,
    status VARCHAR(20) DEFAULT 'PENDING' CHECK (status IN ('PENDING','BOOKED','CANCELLED','COMPLETED','CONFIRMED')),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (table_id) REFERENCES Tables(table_id)
);
GO

-- Orders
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Orders')
CREATE TABLE Orders (
    order_id INT IDENTITY PRIMARY KEY,
    customer_id INT,
    staff_id INT NULL,
    table_id INT,
    reservation_id INT NULL,
    order_time DATETIME DEFAULT GETDATE(),
    status VARCHAR(20) DEFAULT 'OPEN' CHECK (status IN ('OPEN','PAID','CANCELLED')),
    total_amount DECIMAL(12,2) DEFAULT 0,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id),
    FOREIGN KEY (table_id) REFERENCES Tables(table_id),
    FOREIGN KEY (reservation_id) REFERENCES Reservations(reservation_id)
);
GO

-- Order_Items
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Order_Items')
CREATE TABLE Order_Items (
    order_item_id INT IDENTITY PRIMARY KEY,
    order_id INT NOT NULL,
    menu_item_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (menu_item_id) REFERENCES Menu_Items(menu_item_id)
);
GO

-- Payments
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Payments')
CREATE TABLE Payments (
    payment_id INT IDENTITY PRIMARY KEY,
    order_id INT UNIQUE NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    payment_method VARCHAR(20) CHECK (payment_method IN ('CASH','CARD','QR','QR_CODE')),
    payment_time DATETIME DEFAULT GETDATE(),
    total_amount DECIMAL(18,2) NULL,
    deposit_percentage INT NULL CHECK (deposit_percentage IN (30, 50, 100)),
    deposit_amount DECIMAL(10,2) NULL,
    remaining_amount DECIMAL(10,2) NULL,
    payment_status VARCHAR(20) DEFAULT 'PENDING' CHECK (payment_status IN ('PENDING', 'PARTIAL', 'COMPLETED', 'REFUNDED')),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);
GO

PRINT '✓ Tables created successfully';
PRINT '';

-- =============================================
-- 2. INSERT SAMPLE DATA
-- =============================================

-- System Staff
IF NOT EXISTS (SELECT * FROM Users WHERE username = 'system')
BEGIN
    INSERT INTO Users (username, password_hash, email, role, status) 
    VALUES('system', '$2a$10$systemhash', 'system@restaurant.com', 'STAFF', 'ACTIVE');
    
    DECLARE @systemUserId INT = SCOPE_IDENTITY();
    INSERT INTO Staff (user_id, full_name, position, status) 
    VALUES(@systemUserId, N'Hệ Thống Online', 'Online System', 'ACTIVE');
    
    PRINT '✓ System staff created';
END
GO

-- Tables (30 tables)
IF NOT EXISTS (SELECT * FROM Tables)
BEGIN
    -- Khu Vực Cửa Sổ: Tables 1-10
    INSERT INTO Tables (area, capacity, status) VALUES
    (N'Khu Vực Cửa Sổ', 2, 'AVAILABLE'),
    (N'Khu Vực Cửa Sổ', 2, 'AVAILABLE'),
    (N'Khu Vực Cửa Sổ', 4, 'AVAILABLE'),
    (N'Khu Vực Cửa Sổ', 4, 'AVAILABLE'),
    (N'Khu Vực Cửa Sổ', 2, 'AVAILABLE'),
    (N'Khu Vực Cửa Sổ', 4, 'AVAILABLE'),
    (N'Khu Vực Cửa Sổ', 6, 'AVAILABLE'),
    (N'Khu Vực Cửa Sổ', 6, 'AVAILABLE'),
    (N'Khu Vực Cửa Sổ', 2, 'AVAILABLE'),
    (N'Khu Vực Cửa Sổ', 4, 'AVAILABLE');
    
    -- Khu Vườn Nhiệt Đới: Tables 11-20
    INSERT INTO Tables (area, capacity, status) VALUES
    (N'Khu Vườn Nhiệt Đới', 4, 'AVAILABLE'),
    (N'Khu Vườn Nhiệt Đới', 4, 'AVAILABLE'),
    (N'Khu Vườn Nhiệt Đới', 6, 'AVAILABLE'),
    (N'Khu Vườn Nhiệt Đới', 6, 'AVAILABLE'),
    (N'Khu Vườn Nhiệt Đới', 4, 'AVAILABLE'),
    (N'Khu Vườn Nhiệt Đới', 8, 'AVAILABLE'),
    (N'Khu Vườn Nhiệt Đới', 4, 'AVAILABLE'),
    (N'Khu Vườn Nhiệt Đới', 6, 'AVAILABLE'),
    (N'Khu Vườn Nhiệt Đới', 4, 'AVAILABLE'),
    (N'Khu Vườn Nhiệt Đới', 6, 'AVAILABLE');
    
    -- Khu Vực VIP: Tables 21-30
    INSERT INTO Tables (area, capacity, status) VALUES
    (N'Khu Vực VIP', 8, 'AVAILABLE'),
    (N'Khu Vực VIP', 8, 'AVAILABLE'),
    (N'Khu Vực VIP', 10, 'AVAILABLE'),
    (N'Khu Vực VIP', 10, 'AVAILABLE'),
    (N'Khu Vực VIP', 12, 'AVAILABLE'),
    (N'Khu Vực VIP', 8, 'AVAILABLE'),
    (N'Khu Vực VIP', 10, 'AVAILABLE'),
    (N'Khu Vực VIP', 12, 'AVAILABLE'),
    (N'Khu Vực VIP', 8, 'AVAILABLE'),
    (N'Khu Vực VIP', 10, 'AVAILABLE');
    
    PRINT '✓ Inserted 30 tables';
END
GO

-- Menu Items
IF NOT EXISTS (SELECT * FROM Menu_Items)
BEGIN
    INSERT INTO Menu_Items (name, price, status, category, description) VALUES
    -- Khai Vị
    (N'Sò Điệp Hokkaido Áp Chảo', 850000, 'AVAILABLE', N'Khai vị', N'Món khai vị cao cấp'),
    (N'Gan Ngỗng Pháp Áp Chảo', 1250000, 'AVAILABLE', N'Khai vị', N'Món khai vị cao cấp'),
    (N'Salad Cá Hồi Nauy', 450000, 'AVAILABLE', N'Khai vị', N'Món khai vị cao cấp'),
    -- Món Chính
    (N'Bò Wagyu Thượng Hạng', 2500000, 'AVAILABLE', N'Món chính', N'Món chính đặc sắc'),
    (N'Tôm Hùm Alaska Sốt Bơ', 3200000, 'AVAILABLE', N'Món chính', N'Món chính đặc sắc'),
    (N'Thăn Lưng Black Angus', 1200000, 'AVAILABLE', N'Món chính', N'Món chính đặc sắc'),
    -- Tráng Miệng
    (N'Tiramisu Ý', 180000, 'AVAILABLE', N'Tráng miệng', N'Tráng miệng ngọt ngào'),
    (N'Crème Brûlée', 150000, 'AVAILABLE', N'Tráng miệng', N'Tráng miệng ngọt ngào'),
    -- Đồ Uống
    (N'Rượu Vang Đỏ Bordeaux', 1500000, 'AVAILABLE', N'Đồ uống', N'Đồ uống cao cấp'),
    (N'Nước Ép Cam Tươi', 80000, 'AVAILABLE', N'Đồ uống', N'Đồ uống cao cấp'),
    -- Test Items
    (N'[TEST] Bánh Mì', 10000, 'AVAILABLE', N'Khai vị', N'Test item'),
    (N'[TEST] Cơm Trắng', 10000, 'AVAILABLE', N'Món chính', N'Test item'),
    (N'[TEST] Nước Suối', 10000, 'AVAILABLE', N'Đồ uống', N'Test item');
    
    PRINT '✓ Inserted menu items';
END
GO

-- =============================================
-- 3. CREATE INDEXES
-- =============================================

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Tables_Status')
    CREATE INDEX IX_Tables_Status ON Tables(status);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Reservations_Customer')
    CREATE INDEX IX_Reservations_Customer ON Reservations(customer_id, status);

PRINT '✓ Indexes created';
PRINT '';

-- =============================================
-- 4. VERIFICATION
-- =============================================

PRINT '========================================';
PRINT 'SETUP COMPLETED SUCCESSFULLY!';
PRINT '========================================';
PRINT '';

SELECT 
    'Tables' as Item, 
    COUNT(*) as Total,
    COUNT(CASE WHEN status = 'AVAILABLE' THEN 1 END) as Available
FROM Tables;

SELECT 
    'Menu Items' as Item, 
    COUNT(*) as Total
FROM Menu_Items;

SELECT 
    'Staff' as Item, 
    COUNT(*) as Total
FROM Staff;

PRINT '';
PRINT 'Database is ready!';
PRINT '';
PRINT 'Next steps:';
PRINT '1. Restart Tomcat server';
PRINT '2. Go to http://localhost:9999/Smart-Restaurant/booking';
PRINT '3. Select date, time, guests and click "Tìm Bàn"';
PRINT '';
GO
