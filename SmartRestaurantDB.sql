-- =============================================
-- Smart Restaurant Database - Complete Setup
-- GIỮ NGUYÊN tất cả tables, CHỈ THÊM fields cần thiết
-- =============================================

USE master;
GO

-- Create database if not exists
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'SmartRestaurantDB')
CREATE DATABASE SmartRestaurantDB;
GO

USE SmartRestaurantDB;
GO

-- =============================================
-- 1. USERS & AUTHENTICATION (GIỮ NGUYÊN)
-- =============================================

/* Users với phân quyền */
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

-- =============================================
-- 2. SHIFT MANAGEMENT (GIỮ NGUYÊN)
-- =============================================

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Shifts')
CREATE TABLE Shifts (
    shift_id INT IDENTITY PRIMARY KEY,
    shift_name VARCHAR(50) NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL
);
GO

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Staff_Shifts')
CREATE TABLE Staff_Shifts (
    staff_id INT,
    shift_id INT,
    shift_date DATE NOT NULL,
    PRIMARY KEY (staff_id, shift_id, shift_date),
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id),
    FOREIGN KEY (shift_id) REFERENCES Shifts(shift_id)
);
GO

-- =============================================
-- 3. TABLES (GIỮ NGUYÊN)
-- =============================================

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Tables')
CREATE TABLE Tables (
    table_id INT IDENTITY PRIMARY KEY,
    area NVARCHAR(50),
    capacity INT NOT NULL CHECK (capacity > 0),
    status VARCHAR(20) DEFAULT 'AVAILABLE' CHECK (status IN ('AVAILABLE','OCCUPIED','RESERVED'))
);
GO

-- =============================================
-- 4. QUEUE & RESERVATIONS (GIỮ NGUYÊN + THÊM)
-- =============================================

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Queue_Tickets')
CREATE TABLE Queue_Tickets (
    queue_id INT IDENTITY PRIMARY KEY,
    customer_id INT NULL,
    queue_date DATE NOT NULL,
    ticket_number INT NOT NULL,
    guest_count INT NOT NULL,
    priority VARCHAR(20) DEFAULT 'NORMAL' CHECK (priority IN ('NORMAL','VIP')),
    status VARCHAR(20) DEFAULT 'WAITING' CHECK (status IN ('WAITING','CALLED','CANCELLED')),
    created_time DATETIME DEFAULT GETDATE(),
    called_time DATETIME NULL,
    UNIQUE (queue_date, ticket_number),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
GO

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Reservations')
CREATE TABLE Reservations (
    reservation_id INT IDENTITY PRIMARY KEY,
    customer_id INT NOT NULL,
    reservation_time DATETIME NOT NULL,
    guest_count INT NOT NULL,
    status VARCHAR(20) DEFAULT 'BOOKED' CHECK (status IN ('BOOKED','CANCELLED','COMPLETED')),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
GO

-- THÊM: table_id cho Reservations (cho booking system)
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Reservations') AND name = 'table_id')
BEGIN
    ALTER TABLE Reservations ADD table_id INT NULL;
    ALTER TABLE Reservations ADD CONSTRAINT FK_Reservations_Tables FOREIGN KEY (table_id) REFERENCES Tables(table_id);
    PRINT 'Added table_id to Reservations';
END
GO

-- THÊM: CONFIRMED status cho Reservations
IF NOT EXISTS (
    SELECT * FROM sys.check_constraints 
    WHERE parent_object_id = OBJECT_ID('Reservations') 
    AND definition LIKE '%CONFIRMED%'
)
BEGIN
    -- Drop old constraint
    DECLARE @ConstraintName nvarchar(200)
    SELECT @ConstraintName = Name FROM sys.check_constraints 
    WHERE parent_object_id = OBJECT_ID('Reservations') AND COL_NAME(parent_object_id, parent_column_id) = 'status'
    
    IF @ConstraintName IS NOT NULL
        EXEC('ALTER TABLE Reservations DROP CONSTRAINT ' + @ConstraintName)
    
    -- Add new constraint with CONFIRMED
    ALTER TABLE Reservations ADD CONSTRAINT CK_Reservations_Status 
        CHECK (status IN ('BOOKED','CANCELLED','COMPLETED','CONFIRMED'));
    PRINT 'Added CONFIRMED status to Reservations';
END
GO

-- =============================================
-- 5. MENU ITEMS (GIỮ NGUYÊN)
-- =============================================

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Menu_Items')
CREATE TABLE Menu_Items (
    menu_item_id INT IDENTITY PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'AVAILABLE'
);
GO

-- =============================================
-- 6. ORDERS (GIỮ NGUYÊN + THÊM)
-- =============================================

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Orders')
CREATE TABLE Orders (
    order_id INT IDENTITY PRIMARY KEY,
    customer_id INT,
    staff_id INT NOT NULL,
    table_id INT,
    order_time DATETIME DEFAULT GETDATE(),
    status VARCHAR(20) DEFAULT 'OPEN' CHECK (status IN ('OPEN','PAID','CANCELLED')),
    total_amount DECIMAL(12,2) DEFAULT 0,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id),
    FOREIGN KEY (table_id) REFERENCES Tables(table_id)
);
GO

-- THÊM: reservation_id cho Orders (link với Reservations)
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Orders') AND name = 'reservation_id')
BEGIN
    ALTER TABLE Orders ADD reservation_id INT NULL;
    ALTER TABLE Orders ADD CONSTRAINT FK_Orders_Reservations FOREIGN KEY (reservation_id) REFERENCES Reservations(reservation_id);
    PRINT 'Added reservation_id to Orders';
END
GO

-- THÊM: Cho phép staff_id NULL cho online orders
IF EXISTS (
    SELECT * FROM sys.columns 
    WHERE object_id = OBJECT_ID('Orders') 
    AND name = 'staff_id' 
    AND is_nullable = 0
)
BEGIN
    ALTER TABLE Orders ALTER COLUMN staff_id INT NULL;
    PRINT 'Made staff_id nullable in Orders';
END
GO

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

-- =============================================
-- 7. PAYMENTS (GIỮ NGUYÊN + THÊM)
-- =============================================

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Payments')
CREATE TABLE Payments (
    payment_id INT IDENTITY PRIMARY KEY,
    order_id INT UNIQUE NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    payment_method VARCHAR(20) CHECK (payment_method IN ('CASH','CARD','QR')),
    payment_time DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);
GO

-- THÊM: Deposit fields cho Payments
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Payments') AND name = 'total_amount')
    ALTER TABLE Payments ADD total_amount DECIMAL(18,2) NULL;
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Payments') AND name = 'deposit_percentage')
    ALTER TABLE Payments ADD deposit_percentage INT NULL CHECK (deposit_percentage IN (30, 50, 100));
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Payments') AND name = 'deposit_amount')
    ALTER TABLE Payments ADD deposit_amount DECIMAL(10,2) NULL;
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Payments') AND name = 'remaining_amount')
    ALTER TABLE Payments ADD remaining_amount DECIMAL(10,2) NULL;
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Payments') AND name = 'payment_status')
    ALTER TABLE Payments ADD payment_status VARCHAR(20) DEFAULT 'PENDING' CHECK (payment_status IN ('PENDING', 'PARTIAL', 'COMPLETED', 'REFUNDED'));
GO

PRINT 'Added deposit fields to Payments';

-- =============================================
-- 8. INGREDIENTS & INVENTORY (GIỮ NGUYÊN)
-- =============================================

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Ingredients')
CREATE TABLE Ingredients (
    ingredient_id INT IDENTITY PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    unit VARCHAR(20) NOT NULL
);
GO

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Menu_Ingredients')
CREATE TABLE Menu_Ingredients (
    menu_item_id INT,
    ingredient_id INT,
    quantity_required DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (menu_item_id, ingredient_id),
    FOREIGN KEY (menu_item_id) REFERENCES Menu_Items(menu_item_id),
    FOREIGN KEY (ingredient_id) REFERENCES Ingredients(ingredient_id)
);
GO

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Suppliers')
CREATE TABLE Suppliers (
    supplier_id INT IDENTITY PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    certification NVARCHAR(100)
);
GO

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Inventory')
CREATE TABLE Inventory (
    inventory_id INT IDENTITY PRIMARY KEY,
    ingredient_id INT NOT NULL,
    supplier_id INT,
    quantity DECIMAL(10,2) NOT NULL,
    expiry_date DATE,
    status VARCHAR(20) CHECK (status IN ('GOOD','LOW','EXPIRED')),
    last_updated DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ingredient_id) REFERENCES Ingredients(ingredient_id),
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
);
GO

-- =============================================
-- 9. ANALYTICS (GIỮ NGUYÊN)
-- =============================================

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Daily_Stats')
CREATE TABLE Daily_Stats (
    stat_date DATE PRIMARY KEY,
    guest_count INT,
    total_revenue DECIMAL(14,2),
    peak_flag BIT
);
GO

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Predictions')
CREATE TABLE Predictions (
    prediction_id INT IDENTITY PRIMARY KEY,
    prediction_date DATE NOT NULL,
    predicted_guest_count INT,
    predicted_revenue DECIMAL(14,2),
    method VARCHAR(50),
    created_at DATETIME DEFAULT GETDATE()
);
GO

-- =============================================
-- 10. INSERT SAMPLE DATA
-- =============================================

PRINT '';
PRINT '========================================';
PRINT 'Inserting Sample Data...';
PRINT '========================================';

-- Insert System Staff (for online orders)
IF NOT EXISTS (SELECT * FROM Users WHERE username = 'system')
BEGIN
    PRINT 'Creating system staff...';
    INSERT INTO Users (username, password_hash, email, role, status) VALUES
    ('system', '$2a$10$systemhash', 'system@restaurant.com', 'STAFF', 'ACTIVE');
    
    DECLARE @systemUserId INT = SCOPE_IDENTITY();
    
    INSERT INTO Staff (user_id, full_name, position, status) VALUES
    (@systemUserId, N'Hệ Thống Online', 'Online System', 'ACTIVE');
    
    PRINT 'System staff created!';
END
ELSE
    PRINT 'System staff already exists';
GO

-- Insert Tables (30 tables)
IF NOT EXISTS (SELECT * FROM Tables)
BEGIN
    PRINT 'Inserting 30 tables...';
    
    -- Khu Vực Cửa Sổ (Window Area) - Tables 1-10
    INSERT INTO Tables (area, capacity, status) VALUES
    (N'Khu Vực Cửa Sổ', 2, 'AVAILABLE'),
    (N'Khu Vực Cửa Sổ', 2, 'AVAILABLE'),
    (N'Khu Vực Cửa Sổ', 4, 'AVAILABLE'),
    (N'Khu Vực Cửa Sổ', 4, 'RESERVED'),
    (N'Khu Vực Cửa Sổ', 2, 'AVAILABLE'),
    (N'Khu Vực Cửa Sổ', 4, 'AVAILABLE'),
    (N'Khu Vực Cửa Sổ', 6, 'AVAILABLE'),
    (N'Khu Vực Cửa Sổ', 6, 'OCCUPIED'),
    (N'Khu Vực Cửa Sổ', 2, 'AVAILABLE'),
    (N'Khu Vực Cửa Sổ', 4, 'AVAILABLE');

    -- Khu Vườn Nhiệt Đới (Garden Area) - Tables 11-20
    INSERT INTO Tables (area, capacity, status) VALUES
    (N'Khu Vườn Nhiệt Đới', 4, 'AVAILABLE'),
    (N'Khu Vườn Nhiệt Đới', 4, 'AVAILABLE'),
    (N'Khu Vườn Nhiệt Đới', 6, 'AVAILABLE'),
    (N'Khu Vườn Nhiệt Đới', 6, 'RESERVED'),
    (N'Khu Vườn Nhiệt Đới', 4, 'AVAILABLE'),
    (N'Khu Vườn Nhiệt Đới', 8, 'AVAILABLE'),
    (N'Khu Vườn Nhiệt Đới', 4, 'AVAILABLE'),
    (N'Khu Vườn Nhiệt Đới', 6, 'AVAILABLE'),
    (N'Khu Vườn Nhiệt Đới', 4, 'OCCUPIED'),
    (N'Khu Vườn Nhiệt Đới', 6, 'AVAILABLE');

    -- Khu Vực VIP (VIP Area) - Tables 21-30
    INSERT INTO Tables (area, capacity, status) VALUES
    (N'Khu Vực VIP', 8, 'AVAILABLE'),
    (N'Khu Vực VIP', 8, 'AVAILABLE'),
    (N'Khu Vực VIP', 10, 'AVAILABLE'),
    (N'Khu Vực VIP', 10, 'RESERVED'),
    (N'Khu Vực VIP', 12, 'AVAILABLE'),
    (N'Khu Vực VIP', 8, 'AVAILABLE'),
    (N'Khu Vực VIP', 10, 'AVAILABLE'),
    (N'Khu Vực VIP', 12, 'AVAILABLE'),
    (N'Khu Vực VIP', 8, 'OCCUPIED'),
    (N'Khu Vực VIP', 10, 'AVAILABLE');
    
    PRINT 'Inserted 30 tables!';
END
ELSE
    PRINT 'Tables already exist';
GO

-- Insert Menu Items (23 items)
IF NOT EXISTS (SELECT * FROM Menu_Items)
BEGIN
    PRINT 'Inserting 23 menu items...';
    
    -- Khai Vị (Appetizers)
    INSERT INTO Menu_Items (name, price, status) VALUES
    (N'Sò Điệp Hokkaido Áp Chảo', 850000, 'AVAILABLE'),
    (N'Gan Ngỗng Pháp Áp Chảo', 1250000, 'AVAILABLE'),
    (N'Salad Cá Hồi Nauy', 450000, 'AVAILABLE'),
    (N'Súp Bí Đỏ Hạt Dẻ', 280000, 'AVAILABLE'),
    (N'Bò Wagyu Carpaccio', 950000, 'AVAILABLE');

    -- Món Chính (Main Course)
    INSERT INTO Menu_Items (name, price, status) VALUES
    (N'Bò Wagyu Thượng Hạng', 2500000, 'AVAILABLE'),
    (N'Tôm Hùm Alaska Sốt Bơ', 3200000, 'AVAILABLE'),
    (N'Thăn Lưng Black Angus', 1200000, 'AVAILABLE'),
    (N'Thăn Nội Tenderloin', 1450000, 'AVAILABLE'),
    (N'Tomahawk Dát Vàng', 4500000, 'AVAILABLE'),
    (N'Thăn Ngoại Striploin', 950000, 'AVAILABLE'),
    (N'Cá Hồi Na Uy Nướng', 680000, 'AVAILABLE'),
    (N'Vịt Quay Bắc Kinh', 850000, 'AVAILABLE');

    -- Tráng Miệng (Dessert)
    INSERT INTO Menu_Items (name, price, status) VALUES
    (N'Tiramisu Ý', 180000, 'AVAILABLE'),
    (N'Crème Brûlée', 150000, 'AVAILABLE'),
    (N'Chocolate Lava Cake', 200000, 'AVAILABLE'),
    (N'Panna Cotta Dâu', 160000, 'AVAILABLE'),
    (N'Kem Truffle Đen', 250000, 'AVAILABLE');

    -- Đồ Uống (Beverages)
    INSERT INTO Menu_Items (name, price, status) VALUES
    (N'Rượu Vang Đỏ Bordeaux', 1500000, 'AVAILABLE'),
    (N'Champagne Dom Pérignon', 3500000, 'AVAILABLE'),
    (N'Whisky Macallan 18', 2800000, 'AVAILABLE'),
    (N'Nước Ép Cam Tươi', 80000, 'AVAILABLE'),
    (N'Trà Oolong Đài Loan', 120000, 'AVAILABLE');
    
    -- TEST ITEMS (for testing)
    INSERT INTO Menu_Items (name, price, status) VALUES
    (N'[TEST] Bánh Mì Bơ Tỏi', 10000, 'AVAILABLE'),
    (N'[TEST] Nước Suối', 10000, 'AVAILABLE'),
    (N'[TEST] Cơm Trắng', 10000, 'AVAILABLE');
    
    PRINT 'Inserted 26 menu items (including 3 test items)!';
END
ELSE
    PRINT 'Menu items already exist';
GO

-- =============================================
-- 11. CREATE INDEXES (THÊM MỚI)
-- =============================================

PRINT 'Creating indexes for performance...';

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Tables_Status')
    CREATE INDEX IX_Tables_Status ON Tables(status);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Menu_Items_Status')
    CREATE INDEX IX_Menu_Items_Status ON Menu_Items(status);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Reservations_Customer')
    CREATE INDEX IX_Reservations_Customer ON Reservations(customer_id, status);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Orders_Reservation')
    CREATE INDEX IX_Orders_Reservation ON Orders(reservation_id);

PRINT 'Indexes created!';
GO

-- =============================================
-- 12. VERIFICATION
-- =============================================

PRINT '';
PRINT '========================================';
PRINT 'Database Setup Complete!';
PRINT '========================================';
PRINT '';

SELECT 'Tables' as Item, COUNT(*) as Count FROM Tables;
SELECT 'Menu_Items' as Item, COUNT(*) as Count FROM Menu_Items;
SELECT 'System_Staff' as Item, COUNT(*) as Count FROM Staff WHERE position = 'Online System';

PRINT '';
PRINT 'All tables created/updated successfully!';
PRINT 'Sample data inserted!';
PRINT 'Ready for online booking!';
GO

-- =============================================
-- 1. USERS & AUTHENTICATION
-- =============================================

-- Users với phân quyền
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

-- =============================================
-- 2. SHIFT MANAGEMENT
-- =============================================

-- Shifts
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Shifts')
CREATE TABLE Shifts (
    shift_id INT IDENTITY PRIMARY KEY,
    shift_name VARCHAR(50) NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL
);
GO

-- Staff_Shifts (N-N relationship)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Staff_Shifts')
CREATE TABLE Staff_Shifts (
    staff_id INT,
    shift_id INT,
    shift_date DATE NOT NULL,
    PRIMARY KEY (staff_id, shift_id, shift_date),
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id),
    FOREIGN KEY (shift_id) REFERENCES Shifts(shift_id)
);
GO

-- =============================================
-- 3. TABLES & AREAS
-- =============================================

-- Tables
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Tables')
CREATE TABLE Tables (
    table_id INT IDENTITY PRIMARY KEY,
    area NVARCHAR(50),
    capacity INT NOT NULL CHECK (capacity > 0),
    status VARCHAR(20) DEFAULT 'AVAILABLE' CHECK (status IN ('AVAILABLE','OCCUPIED','RESERVED'))
);
GO

-- =============================================
-- 4. MENU ITEMS
-- =============================================

-- Menu_Items
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Menu_Items')
CREATE TABLE Menu_Items (
    menu_item_id INT IDENTITY PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'AVAILABLE'
);
GO

-- =============================================
-- 5. QUEUE & RESERVATIONS
-- =============================================

-- Queue_Tickets
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Queue_Tickets')
CREATE TABLE Queue_Tickets (
    queue_id INT IDENTITY PRIMARY KEY,
    customer_id INT NULL,
    queue_date DATE NOT NULL,
    ticket_number INT NOT NULL,
    guest_count INT NOT NULL,
    priority VARCHAR(20) DEFAULT 'NORMAL' CHECK (priority IN ('NORMAL','VIP')),
    status VARCHAR(20) DEFAULT 'WAITING' CHECK (status IN ('WAITING','CALLED','CANCELLED')),
    created_time DATETIME DEFAULT GETDATE(),
    called_time DATETIME NULL,
    UNIQUE (queue_date, ticket_number),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
GO

-- Reservations (with table_id for booking system)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Reservations')
CREATE TABLE Reservations (
    reservation_id INT IDENTITY PRIMARY KEY,
    customer_id INT NOT NULL,
    table_id INT NULL,  -- Link to Tables for booking
    reservation_time DATETIME NOT NULL,
    guest_count INT NOT NULL,
    status VARCHAR(20) DEFAULT 'BOOKED' CHECK (status IN ('BOOKED','CANCELLED','COMPLETED','CONFIRMED')),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (table_id) REFERENCES Tables(table_id)
);
GO

-- Add table_id if not exists (for existing databases)
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Reservations') AND name = 'table_id')
BEGIN
    ALTER TABLE Reservations ADD table_id INT NULL;
    ALTER TABLE Reservations ADD CONSTRAINT FK_Reservations_Tables FOREIGN KEY (table_id) REFERENCES Tables(table_id);
END
GO

-- Add CONFIRMED status if not exists
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE name = 'CK_Reservations_Status_Updated')
BEGIN
    ALTER TABLE Reservations DROP CONSTRAINT IF EXISTS CK__Reservati__statu__XXX;
    ALTER TABLE Reservations ADD CONSTRAINT CK_Reservations_Status_Updated 
        CHECK (status IN ('BOOKED','CANCELLED','COMPLETED','CONFIRMED'));
END
GO

-- =============================================
-- 6. ORDERS & ORDER ITEMS
-- =============================================

-- Orders (with reservation_id link)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Orders')
CREATE TABLE Orders (
    order_id INT IDENTITY PRIMARY KEY,
    customer_id INT,
    staff_id INT NOT NULL,
    table_id INT,
    reservation_id INT NULL,  -- Link to Reservations
    order_time DATETIME DEFAULT GETDATE(),
    status VARCHAR(20) DEFAULT 'OPEN' CHECK (status IN ('OPEN','PAID','CANCELLED')),
    total_amount DECIMAL(12,2) DEFAULT 0,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id),
    FOREIGN KEY (table_id) REFERENCES Tables(table_id),
    FOREIGN KEY (reservation_id) REFERENCES Reservations(reservation_id)
);
GO

-- Add reservation_id if not exists
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Orders') AND name = 'reservation_id')
BEGIN
    ALTER TABLE Orders ADD reservation_id INT NULL;
    ALTER TABLE Orders ADD CONSTRAINT FK_Orders_Reservations FOREIGN KEY (reservation_id) REFERENCES Reservations(reservation_id);
END
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

-- =============================================
-- 7. PAYMENTS (with deposit fields)
-- =============================================

-- Payments
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Payments')
CREATE TABLE Payments (
    payment_id INT IDENTITY PRIMARY KEY,
    order_id INT UNIQUE NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    payment_method VARCHAR(20) CHECK (payment_method IN ('CASH','CARD','QR','QR_CODE')),
    payment_time DATETIME DEFAULT GETDATE(),
    -- Deposit fields for booking system
    total_amount DECIMAL(18,2) NULL,
    deposit_percentage INT NULL CHECK (deposit_percentage IN (30, 50, 100)),
    deposit_amount DECIMAL(10,2) NULL,
    remaining_amount DECIMAL(10,2) NULL,
    payment_status VARCHAR(20) DEFAULT 'PENDING' CHECK (payment_status IN ('PENDING', 'PARTIAL', 'COMPLETED', 'REFUNDED')),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);
GO

-- Add deposit fields if not exists
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Payments') AND name = 'total_amount')
    ALTER TABLE Payments ADD total_amount DECIMAL(18,2) NULL;
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Payments') AND name = 'deposit_percentage')
    ALTER TABLE Payments ADD deposit_percentage INT NULL CHECK (deposit_percentage IN (30, 50, 100));
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Payments') AND name = 'deposit_amount')
    ALTER TABLE Payments ADD deposit_amount DECIMAL(10,2) NULL;
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Payments') AND name = 'remaining_amount')
    ALTER TABLE Payments ADD remaining_amount DECIMAL(10,2) NULL;
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Payments') AND name = 'payment_status')
    ALTER TABLE Payments ADD payment_status VARCHAR(20) DEFAULT 'PENDING' CHECK (payment_status IN ('PENDING', 'PARTIAL', 'COMPLETED', 'REFUNDED'));
GO

-- =============================================
-- 8. INGREDIENTS & INVENTORY
-- =============================================

-- Ingredients
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Ingredients')
CREATE TABLE Ingredients (
    ingredient_id INT IDENTITY PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    unit VARCHAR(20) NOT NULL
);
GO

-- Menu_Ingredients (định mức nguyên liệu)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Menu_Ingredients')
CREATE TABLE Menu_Ingredients (
    menu_item_id INT,
    ingredient_id INT,
    quantity_required DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (menu_item_id, ingredient_id),
    FOREIGN KEY (menu_item_id) REFERENCES Menu_Items(menu_item_id),
    FOREIGN KEY (ingredient_id) REFERENCES Ingredients(ingredient_id)
);
GO

-- Suppliers
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Suppliers')
CREATE TABLE Suppliers (
    supplier_id INT IDENTITY PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    certification NVARCHAR(100)
);
GO

-- Inventory
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Inventory')
CREATE TABLE Inventory (
    inventory_id INT IDENTITY PRIMARY KEY,
    ingredient_id INT NOT NULL,
    supplier_id INT,
    quantity DECIMAL(10,2) NOT NULL,
    expiry_date DATE,
    status VARCHAR(20) CHECK (status IN ('GOOD','LOW','EXPIRED')),
    last_updated DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ingredient_id) REFERENCES Ingredients(ingredient_id),
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
);
GO

-- =============================================
-- 9. ANALYTICS & PREDICTIONS
-- =============================================

-- Daily_Stats
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Daily_Stats')
CREATE TABLE Daily_Stats (
    stat_date DATE PRIMARY KEY,
    guest_count INT,
    total_revenue DECIMAL(14,2),
    peak_flag BIT
);
GO

-- Predictions
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Predictions')
CREATE TABLE Predictions (
    prediction_id INT IDENTITY PRIMARY KEY,
    prediction_date DATE NOT NULL,
    predicted_guest_count INT,
    predicted_revenue DECIMAL(14,2),
    method VARCHAR(50),
    created_at DATETIME DEFAULT GETDATE()
);
GO

-- =============================================
-- 10. INSERT SAMPLE DATA
-- =============================================

PRINT '========================================';
PRINT 'Inserting Sample Data...';
PRINT '========================================';

-- Insert Tables (30 tables across 3 areas)
IF NOT EXISTS (SELECT * FROM Tables)
BEGIN
    PRINT 'Inserting Tables...';
    
    -- Khu Vực Cửa Sổ (Window Area) - Tables 1-10
    INSERT INTO Tables (area, capacity, status) VALUES
    (N'Khu Vực Cửa Sổ', 2, 'AVAILABLE'),
    (N'Khu Vực Cửa Sổ', 2, 'AVAILABLE'),
    (N'Khu Vực Cửa Sổ', 4, 'AVAILABLE'),
    (N'Khu Vực Cửa Sổ', 4, 'RESERVED'),
    (N'Khu Vực Cửa Sổ', 2, 'AVAILABLE'),
    (N'Khu Vực Cửa Sổ', 4, 'AVAILABLE'),
    (N'Khu Vực Cửa Sổ', 6, 'AVAILABLE'),
    (N'Khu Vực Cửa Sổ', 6, 'OCCUPIED'),
    (N'Khu Vực Cửa Sổ', 2, 'AVAILABLE'),
    (N'Khu Vực Cửa Sổ', 4, 'AVAILABLE');

    -- Khu Vườn Nhiệt Đới (Garden Area) - Tables 11-20
    INSERT INTO Tables (area, capacity, status) VALUES
    (N'Khu Vườn Nhiệt Đới', 4, 'AVAILABLE'),
    (N'Khu Vườn Nhiệt Đới', 4, 'AVAILABLE'),
    (N'Khu Vườn Nhiệt Đới', 6, 'AVAILABLE'),
    (N'Khu Vườn Nhiệt Đới', 6, 'RESERVED'),
    (N'Khu Vườn Nhiệt Đới', 4, 'AVAILABLE'),
    (N'Khu Vườn Nhiệt Đới', 8, 'AVAILABLE'),
    (N'Khu Vườn Nhiệt Đới', 4, 'AVAILABLE'),
    (N'Khu Vườn Nhiệt Đới', 6, 'AVAILABLE'),
    (N'Khu Vườn Nhiệt Đới', 4, 'OCCUPIED'),
    (N'Khu Vườn Nhiệt Đới', 6, 'AVAILABLE');

    -- Khu Vực VIP (VIP Area) - Tables 21-30
    INSERT INTO Tables (area, capacity, status) VALUES
    (N'Khu Vực VIP', 8, 'AVAILABLE'),
    (N'Khu Vực VIP', 8, 'AVAILABLE'),
    (N'Khu Vực VIP', 10, 'AVAILABLE'),
    (N'Khu Vực VIP', 10, 'RESERVED'),
    (N'Khu Vực VIP', 12, 'AVAILABLE'),
    (N'Khu Vực VIP', 8, 'AVAILABLE'),
    (N'Khu Vực VIP', 10, 'AVAILABLE'),
    (N'Khu Vực VIP', 12, 'AVAILABLE'),
    (N'Khu Vực VIP', 8, 'OCCUPIED'),
    (N'Khu Vực VIP', 10, 'AVAILABLE');
    
    PRINT 'Inserted 30 tables successfully!';
END
ELSE
    PRINT 'Tables already exist, skipping...';
GO

-- Insert Menu Items (23 items)
IF NOT EXISTS (SELECT * FROM Menu_Items)
BEGIN
    PRINT 'Inserting Menu Items...';
    
    -- Khai Vị (Appetizers)
    INSERT INTO Menu_Items (name, price, status) VALUES
    (N'Sò Điệp Hokkaido Áp Chảo', 850000, 'AVAILABLE'),
    (N'Gan Ngỗng Pháp Áp Chảo', 1250000, 'AVAILABLE'),
    (N'Salad Cá Hồi Nauy', 450000, 'AVAILABLE'),
    (N'Súp Bí Đỏ Hạt Dẻ', 280000, 'AVAILABLE'),
    (N'Bò Wagyu Carpaccio', 950000, 'AVAILABLE');

    -- Món Chính (Main Course)
    INSERT INTO Menu_Items (name, price, status) VALUES
    (N'Bò Wagyu Thượng Hạng', 2500000, 'AVAILABLE'),
    (N'Tôm Hùm Alaska Sốt Bơ', 3200000, 'AVAILABLE'),
    (N'Thăn Lưng Black Angus', 1200000, 'AVAILABLE'),
    (N'Thăn Nội Tenderloin', 1450000, 'AVAILABLE'),
    (N'Tomahawk Dát Vàng', 4500000, 'AVAILABLE'),
    (N'Thăn Ngoại Striploin', 950000, 'AVAILABLE'),
    (N'Cá Hồi Na Uy Nướng', 680000, 'AVAILABLE'),
    (N'Vịt Quay Bắc Kinh', 850000, 'AVAILABLE');

    -- Tráng Miệng (Dessert)
    INSERT INTO Menu_Items (name, price, status) VALUES
    (N'Tiramisu Ý', 180000, 'AVAILABLE'),
    (N'Crème Brûlée', 150000, 'AVAILABLE'),
    (N'Chocolate Lava Cake', 200000, 'AVAILABLE'),
    (N'Panna Cotta Dâu', 160000, 'AVAILABLE'),
    (N'Kem Truffle Đen', 250000, 'AVAILABLE');

    -- Đồ Uống (Beverages)
    INSERT INTO Menu_Items (name, price, status) VALUES
    (N'Rượu Vang Đỏ Bordeaux', 1500000, 'AVAILABLE'),
    (N'Champagne Dom Pérignon', 3500000, 'AVAILABLE'),
    (N'Whisky Macallan 18', 2800000, 'AVAILABLE'),
    (N'Nước Ép Cam Tươi', 80000, 'AVAILABLE'),
    (N'Trà Oolong Đài Loan', 120000, 'AVAILABLE');
    
    PRINT 'Inserted 23 menu items successfully!';
END
ELSE
    PRINT 'Menu Items already exist, skipping...';
GO

-- Insert Sample Staff (for Orders - required foreign key)
IF NOT EXISTS (SELECT * FROM Users WHERE role = 'STAFF')
BEGIN
    PRINT 'Inserting Sample Staff...';
    
    INSERT INTO Users (username, password_hash, email, role, status) VALUES
    ('staff01', '$2a$10$dummyhash', 'staff@restaurant.com', 'STAFF', 'ACTIVE');
    
    DECLARE @staffUserId INT = SCOPE_IDENTITY();
    
    INSERT INTO Staff (user_id, full_name, position, status) VALUES
    (@staffUserId, N'Nhân Viên Hệ Thống', 'Server', 'ACTIVE');
    
    PRINT 'Inserted sample staff successfully!';
END
ELSE
    PRINT 'Staff already exists, skipping...';
GO

-- =============================================
-- 11. VERIFICATION
-- =============================================

PRINT '';
PRINT '========================================';
PRINT 'Database Setup Complete!';
PRINT '========================================';
PRINT '';

-- Show table counts
PRINT 'Table Counts:';
SELECT 
    'Tables' as TableName, 
    COUNT(*) as RecordCount,
    COUNT(CASE WHEN status = 'AVAILABLE' THEN 1 END) as Available,
    COUNT(CASE WHEN status = 'RESERVED' THEN 1 END) as Reserved,
    COUNT(CASE WHEN status = 'OCCUPIED' THEN 1 END) as Occupied
FROM Tables;

SELECT 
    'Menu_Items' as TableName, 
    COUNT(*) as RecordCount,
    MIN(price) as MinPrice,
    MAX(price) as MaxPrice
FROM Menu_Items;

SELECT 
    'Users' as TableName, 
    COUNT(*) as RecordCount,
    COUNT(CASE WHEN role = 'CUSTOMER' THEN 1 END) as Customers,
    COUNT(CASE WHEN role = 'STAFF' THEN 1 END) as Staff,
    COUNT(CASE WHEN role = 'ADMIN' THEN 1 END) as Admins
FROM Users;

PRINT '';
PRINT 'All tables created successfully!';
PRINT 'Sample data inserted!';
PRINT '';
PRINT 'Next Steps:';
PRINT '1. Register a customer account at /register';
PRINT '2. Login at /login';
PRINT '3. Go to /booking to select a table';
PRINT '4. Select menu items';
PRINT '5. Complete checkout with deposit payment';
PRINT '';
PRINT '========================================';
GO


-- =============================================
-- Verify Database Setup
-- Chạy script này để kiểm tra database đã setup đúng chưa
-- =============================================







USE SmartRestaurantDB;
GO

PRINT '========================================';
PRINT 'Verifying Database Setup...';
PRINT '========================================';
PRINT '';

-- 1. Check all tables exist
PRINT '1. Checking Tables...';
SELECT name as TableName 
FROM sys.tables 
WHERE name IN ('Users', 'Customers', 'Staff', 'Tables', 'Menu_Items', 'Reservations', 'Orders', 'Order_Items', 'Payments')
ORDER BY name;
PRINT '';

-- 2. Check record counts
PRINT '2. Checking Record Counts...';
SELECT 'Users' as TableName, COUNT(*) as RecordCount FROM Users
UNION ALL
SELECT 'Customers', COUNT(*) FROM Customers
UNION ALL
SELECT 'Staff', COUNT(*) FROM Staff
UNION ALL
SELECT 'Tables', COUNT(*) FROM Tables
UNION ALL
SELECT 'Menu_Items', COUNT(*) FROM Menu_Items
UNION ALL
SELECT 'Reservations', COUNT(*) FROM Reservations
UNION ALL
SELECT 'Orders', COUNT(*) FROM Orders
UNION ALL
SELECT 'Payments', COUNT(*) FROM Payments;
PRINT '';

-- 3. Check System Staff exists
PRINT '3. Checking System Staff...';
SELECT u.username, s.full_name, s.position, s.status
FROM Staff s
JOIN Users u ON s.user_id = u.user_id
WHERE s.position = 'Online System';
PRINT '';

-- 4. Check Tables data
PRINT '4. Checking Tables Distribution...';
SELECT 
    area,
    COUNT(*) as total_tables,
    SUM(CASE WHEN status = 'AVAILABLE' THEN 1 ELSE 0 END) as available,
    SUM(CASE WHEN status = 'RESERVED' THEN 1 ELSE 0 END) as reserved,
    SUM(CASE WHEN status = 'OCCUPIED' THEN 1 ELSE 0 END) as occupied
FROM Tables
GROUP BY area
ORDER BY area;
PRINT '';

-- 5. Check Menu Items
PRINT '5. Checking Menu Items...';
SELECT 
    COUNT(*) as total_items,
    MIN(price) as min_price,
    MAX(price) as max_price,
    AVG(price) as avg_price
FROM Menu_Items;
PRINT '';

-- 6. Check Reservations columns
PRINT '6. Checking Reservations Columns...';
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Reservations'
ORDER BY ORDINAL_POSITION;
PRINT '';

-- 7. Check Orders columns
PRINT '7. Checking Orders Columns...';
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Orders'
AND COLUMN_NAME IN ('staff_id', 'reservation_id')
ORDER BY ORDINAL_POSITION;
PRINT '';

-- 8. Check Payments columns
PRINT '8. Checking Payments Deposit Fields...';
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Payments'
AND COLUMN_NAME IN ('total_amount', 'deposit_percentage', 'deposit_amount', 'remaining_amount', 'payment_status')
ORDER BY ORDINAL_POSITION;
PRINT '';

-- 9. Check Foreign Keys
PRINT '9. Checking Foreign Keys...';
SELECT 
    fk.name as FK_Name,
    OBJECT_NAME(fk.parent_object_id) as TableName,
    COL_NAME(fkc.parent_object_id, fkc.parent_column_id) as ColumnName,
    OBJECT_NAME(fk.referenced_object_id) as ReferencedTable
FROM sys.foreign_keys fk
INNER JOIN sys.foreign_key_columns fkc ON fk.object_id = fkc.constraint_object_id
WHERE OBJECT_NAME(fk.parent_object_id) IN ('Reservations', 'Orders', 'Payments')
ORDER BY TableName, FK_Name;
PRINT '';

-- 10. Check Indexes
PRINT '10. Checking Indexes...';
SELECT 
    t.name as TableName,
    i.name as IndexName,
    i.type_desc as IndexType
FROM sys.indexes i
JOIN sys.tables t ON i.object_id = t.object_id
WHERE t.name IN ('Tables', 'Menu_Items', 'Reservations', 'Orders')
AND i.name IS NOT NULL
ORDER BY t.name, i.name;
PRINT '';

PRINT '========================================';
PRINT 'Verification Complete!';
PRINT '========================================';
PRINT '';
PRINT 'Expected Results:';
PRINT '- System Staff: 1 record';
PRINT '- Tables: 30 records (10 per area)';
PRINT '- Menu_Items: 23 records';
PRINT '- Reservations.table_id: EXISTS, nullable';
PRINT '- Orders.staff_id: EXISTS, nullable';
PRINT '- Orders.reservation_id: EXISTS, nullable';
PRINT '- Payments: 5 deposit fields';
PRINT '';
GO


UPDATE users 
SET role = 'CUSTOMER' 
WHERE user_id = 1;


UPDATE users 
SET role = 'STAFF' 
WHERE user_id = 1;


select * from users
