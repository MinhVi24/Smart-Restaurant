-- =============================================
-- Smart Restaurant Database - Complete Setup
-- Optimized and Clean Version
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
-- 1. USERS & AUTHENTICATION
-- =============================================

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
-- 2. SHIFT MANAGEMENT
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
-- 3. TABLES
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
-- 4. QUEUE & RESERVATIONS
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
    status VARCHAR(20) DEFAULT 'BOOKED' CHECK (status IN ('PENDING','BOOKED','CANCELLED','COMPLETED','CONFIRMED')),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
GO

-- Add table_id to Reservations
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Reservations') AND name = 'table_id')
BEGIN
    ALTER TABLE Reservations ADD table_id INT NULL;
    ALTER TABLE Reservations ADD CONSTRAINT FK_Reservations_Tables FOREIGN KEY (table_id) REFERENCES Tables(table_id);
    PRINT 'Added table_id to Reservations';
END
GO

-- Update Reservations status constraint to include PENDING
IF NOT EXISTS (
    SELECT * FROM sys.check_constraints 
    WHERE parent_object_id = OBJECT_ID('Reservations') 
    AND definition LIKE '%PENDING%'
)
BEGIN
    DECLARE @ConstraintName nvarchar(200)
    SELECT @ConstraintName = Name FROM sys.check_constraints 
    WHERE parent_object_id = OBJECT_ID('Reservations') AND COL_NAME(parent_object_id, parent_column_id) = 'status'
    
    IF @ConstraintName IS NOT NULL
        EXEC('ALTER TABLE Reservations DROP CONSTRAINT ' + @ConstraintName)
    
    ALTER TABLE Reservations ADD CONSTRAINT CK_Reservations_Status 
        CHECK (status IN ('PENDING','BOOKED','CANCELLED','COMPLETED','CONFIRMED'));
    PRINT 'Updated Reservations status constraint with PENDING';
END
GO

-- =============================================
-- 5. MENU ITEMS
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
-- 6. ORDERS
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

-- Add reservation_id to Orders
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Orders') AND name = 'reservation_id')
BEGIN
    ALTER TABLE Orders ADD reservation_id INT NULL;
    ALTER TABLE Orders ADD CONSTRAINT FK_Orders_Reservations FOREIGN KEY (reservation_id) REFERENCES Reservations(reservation_id);
    PRINT 'Added reservation_id to Orders';
END
GO

-- Make staff_id nullable for online orders
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
-- 7. PAYMENTS
-- =============================================

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Payments')
CREATE TABLE Payments (
    payment_id INT IDENTITY PRIMARY KEY,
    order_id INT UNIQUE NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    payment_method VARCHAR(20) CHECK (payment_method IN ('CASH','CARD','QR','QR_CODE')),
    payment_time DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);
GO

-- Add deposit fields to Payments
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

PRINT 'Payment deposit fields configured';

-- =============================================
-- 8. INGREDIENTS & INVENTORY
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
-- 9. ANALYTICS
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
-- 10. CREATE INDEXES FOR PERFORMANCE
-- =============================================

PRINT 'Creating indexes...';

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Tables_Status')
    CREATE INDEX IX_Tables_Status ON Tables(status);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Menu_Items_Status')
    CREATE INDEX IX_Menu_Items_Status ON Menu_Items(status);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Reservations_Customer')
    CREATE INDEX IX_Reservations_Customer ON Reservations(customer_id, status);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Orders_Reservation')
    CREATE INDEX IX_Orders_Reservation ON Orders(reservation_id);

PRINT 'Indexes created';
GO

-- =============================================
-- 11. INSERT SAMPLE DATA
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
    
    PRINT 'System staff created';
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
    (N'Khu Vực Cửa Sổ', 4, 'AVAILABLE'),
    (N'Khu Vực Cửa Sổ', 2, 'AVAILABLE'),
    (N'Khu Vực Cửa Sổ', 4, 'AVAILABLE'),
    (N'Khu Vực Cửa Sổ', 6, 'AVAILABLE'),
    (N'Khu Vực Cửa Sổ', 6, 'AVAILABLE'),
    (N'Khu Vực Cửa Sổ', 2, 'AVAILABLE'),
    (N'Khu Vực Cửa Sổ', 4, 'AVAILABLE');

    -- Khu Vườn Nhiệt Đới (Garden Area) - Tables 11-20
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

    -- Khu Vực VIP (VIP Area) - Tables 21-30
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
    
    PRINT 'Inserted 30 tables';
END
ELSE
    PRINT 'Tables already exist';
GO

-- Insert Menu Items
IF NOT EXISTS (SELECT * FROM Menu_Items)
BEGIN
    PRINT 'Inserting menu items...';
    
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
    
    -- TEST ITEMS (for easy testing)
    INSERT INTO Menu_Items (name, price, status) VALUES
    (N'[TEST] Bánh Mì Bơ Tỏi', 10000, 'AVAILABLE'),
    (N'[TEST] Nước Suối', 10000, 'AVAILABLE'),
    (N'[TEST] Cơm Trắng', 10000, 'AVAILABLE');
    
    PRINT 'Inserted 26 menu items (23 regular + 3 test)';
END
ELSE
    PRINT 'Menu items already exist';
GO

-- =============================================
-- 12. VERIFICATION
-- =============================================

PRINT '';
PRINT '========================================';
PRINT 'Database Setup Complete!';
PRINT '========================================';
PRINT '';

-- Show summary
SELECT 'Tables' as Item, COUNT(*) as Count FROM Tables;
SELECT 'Menu_Items' as Item, COUNT(*) as Count FROM Menu_Items;
SELECT 'System_Staff' as Item, COUNT(*) as Count FROM Staff WHERE position = 'Online System';

PRINT '';
PRINT 'Database is ready for use!';
PRINT '';
PRINT 'Next Steps:';
PRINT '1. Register a customer account at /register';
PRINT '2. Login at /login';
PRINT '3. Go to /booking to select a table';
PRINT '4. Select menu items';
PRINT '5. Complete checkout with deposit payment (30%, 50%, or 100%)';
PRINT '6. Scan QR code to pay via Sepay';
PRINT '7. System auto-confirms when payment is detected';
PRINT '';
PRINT '========================================';
GO
