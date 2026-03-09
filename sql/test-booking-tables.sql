-- ============================================================
-- TEST DATA: Đặt bàn & Quản lý bàn
-- Chạy file này sau khi đã chạy cleanup-data.sql
-- ============================================================
-- Constraint hợp lệ:
--   Tables.status:       AVAILABLE, OCCUPIED, RESERVED
--   Reservations.status: BOOKED, CANCELLED, COMPLETED, CONFIRMED
-- ============================================================

-- ============================================================
-- 1. XÓA data cũ (theo thứ tự FK)
-- ============================================================
DELETE FROM Payments;
DELETE FROM Order_Items;
DELETE FROM Orders;
DELETE FROM Reservations;
DELETE FROM [Tables];

-- ============================================================
-- 2. TABLES - 12 bàn, 3 khu vực, nhiều trạng thái
-- ============================================================
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
(N'Khu Vực VIP', 10, 'RESERVED'),
(N'Khu Vực VIP', 12, 'AVAILABLE');

-- ============================================================
-- 3. CUSTOMERS - đảm bảo có customer để tạo reservation
-- ============================================================
DECLARE @c1 INT, @c2 INT, @c3 INT;
SELECT @c1 = MIN(customer_id) FROM Customers;
SELECT @c2 = MIN(customer_id) FROM Customers WHERE customer_id > @c1;
IF @c2 IS NULL SET @c2 = @c1;
SELECT @c3 = MIN(customer_id) FROM Customers WHERE customer_id > @c2;
IF @c3 IS NULL SET @c3 = @c1;

-- ============================================================
-- 4. RESERVATIONS - tạo nhiều đơn BOOKED để test xác nhận
-- ============================================================
-- Lấy table_id các bàn AVAILABLE (staff sẽ confirm -> bàn chuyển RESERVED)
DECLARE @avail1 INT, @avail2 INT, @avail3 INT, @avail4 INT;
SELECT @avail1 = MIN(table_id) FROM [Tables] WHERE status = 'AVAILABLE';
SELECT @avail2 = MIN(table_id) FROM [Tables] WHERE status = 'AVAILABLE' AND table_id > @avail1;
SELECT @avail3 = MIN(table_id) FROM [Tables] WHERE status = 'AVAILABLE' AND table_id > @avail2;
SELECT @avail4 = MIN(table_id) FROM [Tables] WHERE status = 'AVAILABLE' AND table_id > @avail3;

-- Lấy table_id bàn RESERVED (đã có booking cũ)
DECLARE @rsv1 INT;
SELECT @rsv1 = MIN(table_id) FROM [Tables] WHERE status = 'RESERVED';

-- 4 đơn BOOKED (chờ staff xác nhận) -> khi confirm sẽ đổi bàn sang RESERVED
INSERT INTO Reservations (customer_id, table_id, reservation_time, guest_count, status, created_at) VALUES
(@c1, @avail1, '2026-03-04 18:00:00', 2, 'BOOKED', GETDATE()),
(@c2, @avail2, '2026-03-04 18:30:00', 4, 'BOOKED', GETDATE()),
(@c3, @avail3, '2026-03-04 19:00:00', 3, 'BOOKED', GETDATE()),
(@c1, @avail4, '2026-03-04 19:30:00', 5, 'BOOKED', GETDATE());

-- 1 đơn CONFIRMED (đã xác nhận trước đó)
INSERT INTO Reservations (customer_id, table_id, reservation_time, guest_count, status, created_at) VALUES
(@c2, @rsv1, '2026-03-04 12:00:00', 4, 'CONFIRMED', DATEADD(HOUR, -5, GETDATE()));

-- 1 đơn CANCELLED
INSERT INTO Reservations (customer_id, table_id, reservation_time, guest_count, status, created_at) VALUES
(@c3, @avail1, '2026-03-03 19:00:00', 2, 'CANCELLED', DATEADD(DAY, -1, GETDATE()));

-- 1 đơn COMPLETED
INSERT INTO Reservations (customer_id, table_id, reservation_time, guest_count, status, created_at) VALUES
(@c1, @avail2, '2026-03-03 20:00:00', 6, 'COMPLETED', DATEADD(DAY, -1, GETDATE()));

-- ============================================================
-- 5. KẾT QUẢ
-- ============================================================
PRINT N'✅ Test data đặt bàn & quản lý bàn đã thêm thành công!';
PRINT N'';
PRINT N'📋 Hướng dẫn test:';
PRINT N'1. Vào /staff/bookings -> thấy 4 đơn BOOKED';
PRINT N'2. Bấm XÁC NHẬN 1 đơn';
PRINT N'3. Vào /staff/tables -> bàn tương ứng chuyển sang RESERVED';
PRINT N'';

SELECT N'Tables' AS [Bảng], status AS [Trạng thái], COUNT(*) AS [Số lượng]
FROM [Tables]
GROUP BY status
ORDER BY status;

SELECT N'Reservations' AS [Bảng], status AS [Trạng thái], COUNT(*) AS [Số lượng]
FROM Reservations
GROUP BY status
ORDER BY status;
