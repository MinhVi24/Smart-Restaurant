-- ============================================================
-- TEST DATA cho Smart Restaurant - Staff Flow
-- Database: SQL Server (SmartRestaurantDB)
-- ============================================================
-- Dựa trên 3 Users còn lại: 1004, 2004, 4005
-- Script CHỈ THÊM data mới, KHÔNG xóa data cũ
-- ============================================================
-- Giá trị CHECK constraint cho phép:
--   Reservations.status: BOOKED, CANCELLED, COMPLETED, CONFIRMED
--   Orders.status:       OPEN, PAID, CANCELLED
--   Payments.method:     CASH, CARD, QR
--   Payments.status:     PENDING, PARTIAL, COMPLETED, REFUNDED
--   Tables.status:       AVAILABLE, OCCUPIED, RESERVED
-- ============================================================

-- ============================================================
-- 1. STAFF
-- ============================================================
IF NOT EXISTS (SELECT 1 FROM Staff WHERE user_id = 4005)
    INSERT INTO Staff (full_name, position, status, user_id)
    VALUES (N'Nguyễn Tín', N'Phục vụ', 'ACTIVE', 4005);

-- ============================================================
-- 2. CUSTOMERS
-- ============================================================
IF NOT EXISTS (SELECT 1 FROM Customers WHERE user_id = 1004)
    INSERT INTO Customers (full_name, phone, membership_level, total_points, created_at, user_id)
    VALUES (N'Tin', '0900001004', N'Regular', 500, GETDATE(), 1004);

-- Thêm 2 customer test
IF NOT EXISTS (SELECT 1 FROM Users WHERE username = 'khachtest1')
    INSERT INTO Users (username, password_hash, email, role, status, created_at)
    VALUES ('khachtest1', '$2a$10$N9qo8uLOickgx2ZMRZoMye.IjSZ1sJ1claH9HAkL3ZlT1oqsRqlie', 'khachtest1@gmail.com', 'CUSTOMER', 'ACTIVE', GETDATE());

IF NOT EXISTS (SELECT 1 FROM Users WHERE username = 'khachtest2')
    INSERT INTO Users (username, password_hash, email, role, status, created_at)
    VALUES ('khachtest2', '$2a$10$N9qo8uLOickgx2ZMRZoMye.IjSZ1sJ1claH9HAkL3ZlT1oqsRqlie', 'khachtest2@gmail.com', 'CUSTOMER', 'ACTIVE', GETDATE());

DECLARE @kt1_uid INT, @kt2_uid INT;
SELECT @kt1_uid = user_id FROM Users WHERE username = 'khachtest1';
SELECT @kt2_uid = user_id FROM Users WHERE username = 'khachtest2';

IF NOT EXISTS (SELECT 1 FROM Customers WHERE user_id = @kt1_uid)
    INSERT INTO Customers (full_name, phone, membership_level, total_points, created_at, user_id)
    VALUES (N'Lê Hoàng Minh', '0901234567', N'Regular', 100, GETDATE(), @kt1_uid);

IF NOT EXISTS (SELECT 1 FROM Customers WHERE user_id = @kt2_uid)
    INSERT INTO Customers (full_name, phone, membership_level, total_points, created_at, user_id)
    VALUES (N'Phạm Thị Hương', '0912345678', N'Regular', 1200, GETDATE(), @kt2_uid);

-- ============================================================
-- 3. TABLES (3 khu vực: Khu Vực Cửa Sổ, Khu Vườn Nhiệt Đới, Khu Vực VIP)
-- ============================================================
IF NOT EXISTS (SELECT 1 FROM [Tables])
BEGIN
    INSERT INTO [Tables] (area, capacity, status) VALUES
    -- Khu Vực Cửa Sổ
    (N'Khu Vực Cửa Sổ', 2, 'AVAILABLE'),
    (N'Khu Vực Cửa Sổ', 4, 'AVAILABLE'),
    (N'Khu Vực Cửa Sổ', 4, 'OCCUPIED'),
    (N'Khu Vực Cửa Sổ', 6, 'AVAILABLE'),
    -- Khu Vườn Nhiệt Đới
    (N'Khu Vườn Nhiệt Đới', 2, 'AVAILABLE'),
    (N'Khu Vườn Nhiệt Đới', 4, 'RESERVED'),
    (N'Khu Vườn Nhiệt Đới', 6, 'AVAILABLE'),
    -- Khu Vực VIP
    (N'Khu Vực VIP', 4, 'AVAILABLE'),
    (N'Khu Vực VIP', 6, 'OCCUPIED'),
    (N'Khu Vực VIP', 8, 'AVAILABLE'),
    (N'Khu Vực VIP', 10, 'AVAILABLE'),
    (N'Khu Vực VIP', 12, 'AVAILABLE');
END

-- ============================================================
-- 4. MENU ITEMS
-- ============================================================
IF NOT EXISTS (SELECT 1 FROM Menu_Items)
BEGIN
    INSERT INTO Menu_Items (name, price, status) VALUES
    (N'Phở bò tái',              75000.00,  'AVAILABLE'),
    (N'Cơm tấm sườn bì chả',    65000.00,  'AVAILABLE'),
    (N'Bún bò Huế',              70000.00,  'AVAILABLE'),
    (N'Gỏi cuốn tôm thịt',      45000.00,  'AVAILABLE'),
    (N'Chả giò rế',              55000.00,  'AVAILABLE'),
    (N'Bò lúc lắc',              120000.00, 'AVAILABLE'),
    (N'Tôm hùm nướng phô mai',   350000.00, 'AVAILABLE'),
    (N'Cá hồi áp chảo',         180000.00, 'AVAILABLE'),
    (N'Sườn cừu nướng',          280000.00, 'AVAILABLE'),
    (N'Tiramisu',                 85000.00,  'AVAILABLE'),
    (N'Trà đào cam sả',          35000.00,  'AVAILABLE'),
    (N'Sinh tố bơ',              40000.00,  'AVAILABLE');
END

-- ============================================================
-- 5. RESERVATIONS
--    Allowed: BOOKED, CANCELLED, COMPLETED, CONFIRMED
-- ============================================================
DECLARE @c1 INT, @c2 INT, @c3 INT;
DECLARE @s1 INT;
SELECT @c1 = MIN(customer_id) FROM Customers;
SELECT @c2 = MIN(customer_id) FROM Customers WHERE customer_id > @c1;
SELECT @c3 = MIN(customer_id) FROM Customers WHERE customer_id > @c2;
IF @c3 IS NULL SET @c3 = @c1;
SELECT @s1 = MIN(staff_id) FROM Staff;

DECLARE @t1 INT, @t2 INT, @t3 INT, @t4 INT, @t5 INT;
SELECT @t1 = MIN(table_id) FROM [Tables] WHERE status = 'AVAILABLE';
SELECT @t2 = MIN(table_id) FROM [Tables] WHERE status = 'AVAILABLE' AND table_id > @t1;
SELECT @t3 = MIN(table_id) FROM [Tables] WHERE status = 'AVAILABLE' AND table_id > @t2;
SELECT @t4 = MIN(table_id) FROM [Tables] WHERE status = 'AVAILABLE' AND table_id > @t3;
SELECT @t5 = MIN(table_id) FROM [Tables] WHERE status = 'AVAILABLE' AND table_id > @t4;

IF NOT EXISTS (SELECT 1 FROM Reservations)
BEGIN
    -- 3 BOOKED (chờ xử lý)
    INSERT INTO Reservations (customer_id, table_id, reservation_time, guest_count, status, created_at)
    VALUES (@c1, @t1, '2026-03-04 18:00:00', 2, 'BOOKED', GETDATE());
    INSERT INTO Reservations (customer_id, table_id, reservation_time, guest_count, status, created_at)
    VALUES (@c2, @t2, '2026-03-04 18:30:00', 4, 'BOOKED', GETDATE());
    INSERT INTO Reservations (customer_id, table_id, reservation_time, guest_count, status, created_at)
    VALUES (@c3, @t3, '2026-03-04 19:00:00', 4, 'BOOKED', GETDATE());

    -- 2 CONFIRMED (đã xác nhận)
    INSERT INTO Reservations (customer_id, table_id, reservation_time, guest_count, status, created_at)
    VALUES (@c1, @t4, '2026-03-04 12:00:00', 5, 'CONFIRMED', DATEADD(HOUR, -14, GETDATE()));
    INSERT INTO Reservations (customer_id, table_id, reservation_time, guest_count, status, created_at)
    VALUES (@c2, @t5, '2026-03-04 19:30:00', 6, 'CONFIRMED', DATEADD(HOUR, -13, GETDATE()));

    -- 1 CANCELLED (đã hủy)
    INSERT INTO Reservations (customer_id, table_id, reservation_time, guest_count, status, created_at)
    VALUES (@c3, @t1, '2026-03-03 19:00:00', 2, 'CANCELLED', DATEADD(DAY, -1, GETDATE()));

    -- 1 COMPLETED (hoàn tất)
    INSERT INTO Reservations (customer_id, table_id, reservation_time, guest_count, status, created_at)
    VALUES (@c1, @t2, '2026-03-03 20:00:00', 6, 'COMPLETED', DATEADD(DAY, -1, GETDATE()));
END

-- ============================================================
-- 6. ORDERS
--    Allowed: OPEN, PAID, CANCELLED
-- ============================================================
IF NOT EXISTS (SELECT 1 FROM Orders)
BEGIN
    DECLARE @tocc1 INT, @tocc2 INT;
    SELECT TOP 1 @tocc1 = table_id FROM [Tables] WHERE status = 'OCCUPIED' ORDER BY table_id;
    SELECT TOP 1 @tocc2 = table_id FROM [Tables] WHERE status = 'OCCUPIED' AND table_id <> ISNULL(@tocc1, 0) ORDER BY table_id;
    IF @tocc2 IS NULL SET @tocc2 = @tocc1;
    IF @tocc1 IS NULL SET @tocc1 = @t1;

    DECLARE @rconf INT;
    SELECT TOP 1 @rconf = reservation_id FROM Reservations WHERE status = 'CONFIRMED' ORDER BY reservation_id;

    -- 3 OPEN (đang phục vụ)
    INSERT INTO Orders (customer_id, staff_id, table_id, reservation_id, order_time, status, total_amount)
    VALUES (@c1, @s1, @tocc1, @rconf, '2026-03-04 12:10:00', 'OPEN', 155000.00);
    INSERT INTO Orders (customer_id, staff_id, table_id, reservation_id, order_time, status, total_amount)
    VALUES (@c2, @s1, @tocc2, NULL, '2026-03-04 11:45:00', 'OPEN', 510000.00);
    INSERT INTO Orders (customer_id, staff_id, table_id, reservation_id, order_time, status, total_amount)
    VALUES (@c3, @s1, @tocc1, NULL, '2026-03-04 11:30:00', 'OPEN', 265000.00);

    -- 1 PAID (đã thanh toán)
    INSERT INTO Orders (customer_id, staff_id, table_id, reservation_id, order_time, status, total_amount)
    VALUES (@c1, @s1, @t1, NULL, '2026-03-04 12:30:00', 'PAID', 185000.00);

    -- 1 CANCELLED (đã hủy)
    INSERT INTO Orders (customer_id, staff_id, table_id, reservation_id, order_time, status, total_amount)
    VALUES (@c2, @s1, @t2, NULL, '2026-03-03 19:00:00', 'CANCELLED', 0.00);
END

-- ============================================================
-- 7. ORDER ITEMS
-- ============================================================
IF NOT EXISTS (SELECT 1 FROM Order_Items)
BEGIN
    DECLARE @o1 INT, @o2 INT, @o3 INT, @o4 INT, @o5 INT;
    SELECT @o1 = MIN(order_id) FROM Orders;
    SELECT @o2 = MIN(order_id) FROM Orders WHERE order_id > @o1;
    SELECT @o3 = MIN(order_id) FROM Orders WHERE order_id > @o2;
    SELECT @o4 = MIN(order_id) FROM Orders WHERE order_id > @o3;
    SELECT @o5 = MIN(order_id) FROM Orders WHERE order_id > @o4;

    DECLARE @m1 INT, @m2 INT, @m3 INT, @m4 INT, @m5 INT, @m6 INT;
    SELECT @m1 = MIN(menu_item_id) FROM Menu_Items;
    SELECT @m2 = MIN(menu_item_id) FROM Menu_Items WHERE menu_item_id > @m1;
    SELECT @m3 = MIN(menu_item_id) FROM Menu_Items WHERE menu_item_id > @m2;
    SELECT @m4 = MIN(menu_item_id) FROM Menu_Items WHERE menu_item_id > @m3;
    SELECT @m5 = MIN(menu_item_id) FROM Menu_Items WHERE menu_item_id > @m4;
    SELECT @m6 = MIN(menu_item_id) FROM Menu_Items WHERE menu_item_id > @m5;

    -- Đơn 1 (OPEN): Phở bò + Gỏi cuốn + Trà đào
    INSERT INTO Order_Items (order_id, menu_item_id, quantity, price) VALUES (@o1, @m1, 1, 75000.00);
    INSERT INTO Order_Items (order_id, menu_item_id, quantity, price) VALUES (@o1, @m4, 1, 45000.00);
    INSERT INTO Order_Items (order_id, menu_item_id, quantity, price) VALUES (@o1, @m3, 1, 35000.00);
    -- Đơn 2 (OPEN): Bò lúc lắc + Tôm hùm + Sinh tố bơ
    INSERT INTO Order_Items (order_id, menu_item_id, quantity, price) VALUES (@o2, @m6, 1, 120000.00);
    INSERT INTO Order_Items (order_id, menu_item_id, quantity, price) VALUES (@o2, @m5, 1, 350000.00);
    INSERT INTO Order_Items (order_id, menu_item_id, quantity, price) VALUES (@o2, @m2, 1, 40000.00);
    -- Đơn 3 (OPEN): Cá hồi + Tiramisu
    INSERT INTO Order_Items (order_id, menu_item_id, quantity, price) VALUES (@o3, @m1, 1, 180000.00);
    INSERT INTO Order_Items (order_id, menu_item_id, quantity, price) VALUES (@o3, @m2, 1, 85000.00);
    -- Đơn 4 (PAID): Cơm tấm x2 + Chả giò
    INSERT INTO Order_Items (order_id, menu_item_id, quantity, price) VALUES (@o4, @m3, 2, 65000.00);
    INSERT INTO Order_Items (order_id, menu_item_id, quantity, price) VALUES (@o4, @m4, 1, 55000.00);
END

-- ============================================================
-- 8. PAYMENTS
--    Allowed method: CASH, CARD, QR
--    Allowed status: PENDING, PARTIAL, COMPLETED, REFUNDED
-- ============================================================
IF NOT EXISTS (SELECT 1 FROM Payments)
BEGIN
    DECLARE @p_paid INT, @p_open1 INT, @p_open2 INT;
    SELECT TOP 1 @p_paid = order_id FROM Orders WHERE status = 'PAID';
    SELECT @p_open1 = MIN(order_id) FROM Orders WHERE status = 'OPEN';
    SELECT @p_open2 = MIN(order_id) FROM Orders WHERE status = 'OPEN' AND order_id > @p_open1;

    -- Đơn PAID → COMPLETED payment
    IF @p_paid IS NOT NULL
        INSERT INTO Payments (order_id, amount, payment_method, payment_time, payment_status)
        VALUES (@p_paid, 185000.00, 'CASH', '2026-03-04 13:00:00', 'COMPLETED');

    -- Đơn OPEN 1 → đặt cọc 30%
    IF @p_open1 IS NOT NULL
        INSERT INTO Payments (order_id, amount, payment_method, payment_time, deposit_percentage, deposit_amount, remaining_amount, payment_status)
        VALUES (@p_open1, 155000.00, 'CASH', '2026-03-04 12:10:00', 30, 46500.00, 108500.00, 'PARTIAL');

    -- Đơn OPEN 2 → chưa thanh toán
    IF @p_open2 IS NOT NULL
        INSERT INTO Payments (order_id, amount, payment_method, payment_time, payment_status)
        VALUES (@p_open2, 510000.00, NULL, NULL, 'PENDING');
END

-- ============================================================
-- Kết quả
-- ============================================================
PRINT N'✅ Test data đã thêm thành công!';

SELECT 'Users' AS [Bảng], COUNT(*) AS [Số dòng] FROM Users
UNION ALL SELECT 'Staff', COUNT(*) FROM Staff
UNION ALL SELECT 'Customers', COUNT(*) FROM Customers
UNION ALL SELECT 'Tables', COUNT(*) FROM [Tables]
UNION ALL SELECT 'Menu_Items', COUNT(*) FROM Menu_Items
UNION ALL SELECT 'Reservations', COUNT(*) FROM Reservations
UNION ALL SELECT 'Orders', COUNT(*) FROM Orders
UNION ALL SELECT 'Order_Items', COUNT(*) FROM Order_Items
UNION ALL SELECT 'Payments', COUNT(*) FROM Payments;
