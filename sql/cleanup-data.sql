-- ============================================================
-- CLEANUP: Xóa hết data, CHỈ GIỮ LẠI user_id: 1004, 2004, 4005
-- Database: SQL Server (SmartRestaurantDB)
-- ============================================================

-- 1. Xóa Payments (phụ thuộc Orders)
DELETE FROM Payments;

-- 2. Xóa Order_Items (phụ thuộc Orders, Menu_Items)
DELETE FROM Order_Items;

-- 3. Xóa Orders (phụ thuộc Customers, Staff, Tables, Reservations)
DELETE FROM Orders;

-- 4. Xóa Reservations (phụ thuộc Customers, Tables)
DELETE FROM Reservations;

-- 5. Xóa Customers KHÔNG nằm trong danh sách giữ
DELETE FROM Customers WHERE user_id NOT IN (1004, 2004, 4005);

-- 6. Xóa Staff KHÔNG nằm trong danh sách giữ
DELETE FROM Staff WHERE user_id NOT IN (1004, 2004, 4005);

-- 7. Xóa Menu_Items
DELETE FROM Menu_Items;

-- 8. Xóa Tables
DELETE FROM [Tables];

-- 9. Xóa Users KHÔNG nằm trong danh sách giữ
DELETE FROM Users WHERE user_id NOT IN (1004, 2004, 4005);

-- Kiểm tra kết quả
SELECT * FROM Users;
SELECT * FROM Staff;
SELECT * FROM Customers;

PRINT N'✅ Đã xóa xong! Chỉ còn user_id: 1004, 2004, 4005';
