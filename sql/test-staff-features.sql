-- =============================================
-- Test Data cho Staff (v3 - auto lookup ALL IDs)
-- =============================================
USE SmartRestaurantDB;
GO

-- Giữ nguyên data hiện có, chỉ thêm mới
PRINT 'Checking existing data...';
GO

-- Xem menu_items thực tế
SELECT menu_item_id, name FROM Menu_Items ORDER BY menu_item_id;
GO

DECLARE @staffId INT, @custId INT;
DECLARE @tblVip INT, @tblVip2 INT, @tblNormal INT, @tblGarden INT, @tblN2 INT, @tblG2 INT;
DECLARE @m1 INT, @m2 INT, @m3 INT, @m4 INT, @m5 INT, @m6 INT;

SELECT TOP 1 @staffId = staff_id FROM Staff WHERE status = 'ACTIVE';
SELECT TOP 1 @custId = customer_id FROM Customers;

-- Lấy 6 menu_item_id đầu tiên từ DB
SELECT @m1 = menu_item_id FROM (SELECT menu_item_id, ROW_NUMBER() OVER(ORDER BY menu_item_id) as rn FROM Menu_Items) t WHERE rn = 1;
SELECT @m2 = menu_item_id FROM (SELECT menu_item_id, ROW_NUMBER() OVER(ORDER BY menu_item_id) as rn FROM Menu_Items) t WHERE rn = 2;
SELECT @m3 = menu_item_id FROM (SELECT menu_item_id, ROW_NUMBER() OVER(ORDER BY menu_item_id) as rn FROM Menu_Items) t WHERE rn = 3;
SELECT @m4 = menu_item_id FROM (SELECT menu_item_id, ROW_NUMBER() OVER(ORDER BY menu_item_id) as rn FROM Menu_Items) t WHERE rn = 4;
SELECT @m5 = menu_item_id FROM (SELECT menu_item_id, ROW_NUMBER() OVER(ORDER BY menu_item_id) as rn FROM Menu_Items) t WHERE rn = 5;
SELECT @m6 = menu_item_id FROM (SELECT menu_item_id, ROW_NUMBER() OVER(ORDER BY menu_item_id) as rn FROM Menu_Items) t WHERE rn = 6;

-- Lấy table IDs
SELECT TOP 1 @tblVip    = table_id FROM Tables WHERE area LIKE N'%VIP%' ORDER BY table_id;
SELECT TOP 1 @tblVip2   = table_id FROM Tables WHERE area LIKE N'%VIP%' AND table_id <> ISNULL(@tblVip, 0) ORDER BY table_id;
SELECT TOP 1 @tblNormal = table_id FROM Tables WHERE area LIKE N'%Cửa Sổ%' ORDER BY table_id;
SELECT TOP 1 @tblN2     = table_id FROM Tables WHERE area LIKE N'%Cửa Sổ%' AND table_id <> ISNULL(@tblNormal, 0) ORDER BY table_id;
SELECT TOP 1 @tblGarden = table_id FROM Tables WHERE area LIKE N'%Vườn%' ORDER BY table_id;
SELECT TOP 1 @tblG2     = table_id FROM Tables WHERE area LIKE N'%Vườn%' AND table_id <> ISNULL(@tblGarden, 0) ORDER BY table_id;

-- Fallback
IF @tblVip IS NULL SELECT TOP 1 @tblVip = table_id FROM Tables;
IF @tblVip2 IS NULL SET @tblVip2 = @tblVip;
IF @tblNormal IS NULL SET @tblNormal = @tblVip;
IF @tblN2 IS NULL SET @tblN2 = @tblVip;
IF @tblGarden IS NULL SET @tblGarden = @tblVip;
IF @tblG2 IS NULL SET @tblG2 = @tblVip;

PRINT 'Staff=' + CAST(@staffId AS VARCHAR) + ' Cust=' + CAST(@custId AS VARCHAR);
PRINT 'MenuItems: ' + CAST(@m1 AS VARCHAR)+','+CAST(@m2 AS VARCHAR)+','+CAST(@m3 AS VARCHAR)+','+CAST(@m4 AS VARCHAR)+','+CAST(@m5 AS VARCHAR)+','+CAST(@m6 AS VARCHAR);
PRINT 'Tables VIP=' + CAST(@tblVip AS VARCHAR) + ' Normal=' + CAST(@tblNormal AS VARCHAR) + ' Garden=' + CAST(@tblGarden AS VARCHAR);

IF @staffId IS NULL OR @custId IS NULL OR @m1 IS NULL
BEGIN
    PRINT 'ERROR: Missing staff/customer/menu_items!';
    RETURN;
END

-- ĐƠN 1: VIP, 15p trước (viền đỏ + chữ vàng VIP)
INSERT INTO Orders (customer_id, staff_id, table_id, order_time, status, total_amount)
VALUES (@custId, @staffId, @tblVip, DATEADD(MINUTE, -15, GETDATE()), 'OPEN', 5000000);
DECLARE @o1 INT = SCOPE_IDENTITY();
INSERT INTO Order_Items (order_id, menu_item_id, quantity, price) VALUES (@o1, @m1, 1, 2500000);
INSERT INTO Order_Items (order_id, menu_item_id, quantity, price) VALUES (@o1, @m2, 1, 2500000);
PRINT 'Don 1 OK (VIP, 15p) ID=' + CAST(@o1 AS VARCHAR);

-- ĐƠN 2: Thường, 5p trước
INSERT INTO Orders (customer_id, staff_id, table_id, order_time, status, total_amount)
VALUES (@custId, @staffId, @tblNormal, DATEADD(MINUTE, -5, GETDATE()), 'OPEN', 1500000);
DECLARE @o2 INT = SCOPE_IDENTITY();
INSERT INTO Order_Items (order_id, menu_item_id, quantity, price) VALUES (@o2, @m3, 2, 500000);
INSERT INTO Order_Items (order_id, menu_item_id, quantity, price) VALUES (@o2, @m4, 1, 500000);
PRINT 'Don 2 OK (thuong, 5p) ID=' + CAST(@o2 AS VARCHAR);

-- ĐƠN 3: Vườn, 25p trước (viền đỏ)
INSERT INTO Orders (customer_id, staff_id, table_id, order_time, status, total_amount)
VALUES (@custId, @staffId, @tblGarden, DATEADD(MINUTE, -25, GETDATE()), 'OPEN', 2000000);
DECLARE @o3 INT = SCOPE_IDENTITY();
INSERT INTO Order_Items (order_id, menu_item_id, quantity, price) VALUES (@o3, @m5, 1, 1000000);
INSERT INTO Order_Items (order_id, menu_item_id, quantity, price) VALUES (@o3, @m6, 1, 1000000);
PRINT 'Don 3 OK (vuon, 25p) ID=' + CAST(@o3 AS VARCHAR);

-- ĐƠN 4: VIP, 2p trước
INSERT INTO Orders (customer_id, staff_id, table_id, order_time, status, total_amount)
VALUES (@custId, @staffId, @tblVip2, DATEADD(MINUTE, -2, GETDATE()), 'OPEN', 3000000);
DECLARE @o4 INT = SCOPE_IDENTITY();
INSERT INTO Order_Items (order_id, menu_item_id, quantity, price) VALUES (@o4, @m1, 2, 1500000);
INSERT INTO Order_Items (order_id, menu_item_id, quantity, price) VALUES (@o4, @m3, 1, 1500000);
PRINT 'Don 4 OK (VIP, 2p) ID=' + CAST(@o4 AS VARCHAR);

-- ĐƠN 5: PAID
INSERT INTO Orders (customer_id, staff_id, table_id, order_time, status, total_amount)
VALUES (@custId, @staffId, @tblN2, DATEADD(HOUR, -2, GETDATE()), 'PAID', 800000);
DECLARE @o5 INT = SCOPE_IDENTITY();
INSERT INTO Order_Items (order_id, menu_item_id, quantity, price) VALUES (@o5, @m4, 2, 400000);
PRINT 'Don 5 OK (PAID) ID=' + CAST(@o5 AS VARCHAR);

-- ĐƠN 6: CANCELLED
INSERT INTO Orders (customer_id, staff_id, table_id, order_time, status, total_amount)
VALUES (@custId, @staffId, @tblG2, DATEADD(HOUR, -3, GETDATE()), 'CANCELLED', 500000);
DECLARE @o6 INT = SCOPE_IDENTITY();
INSERT INTO Order_Items (order_id, menu_item_id, quantity, price) VALUES (@o6, @m2, 1, 500000);
PRINT 'Don 6 OK (CANCELLED) ID=' + CAST(@o6 AS VARCHAR);

-- Payments
INSERT INTO Payments (order_id, amount, payment_method, total_amount, deposit_percentage, deposit_amount, remaining_amount, payment_status)
VALUES (@o1, 5000000, 'CARD', 5000000, 30, 1500000, 3500000, 'PARTIAL');
INSERT INTO Payments (order_id, amount, payment_method, total_amount, deposit_percentage, deposit_amount, remaining_amount, payment_status)
VALUES (@o4, 3000000, 'QR', 3000000, 50, 1500000, 1500000, 'PARTIAL');
PRINT 'Payments OK';

PRINT '';
PRINT '=== VERIFY ===';
SELECT o.order_id, o.status, o.total_amount, t.area, o.order_time
FROM Orders o LEFT JOIN Tables t ON o.table_id = t.table_id ORDER BY o.order_id;

SELECT oi.order_id, m.name, oi.quantity, oi.price
FROM Order_Items oi JOIN Menu_Items m ON oi.menu_item_id = m.menu_item_id ORDER BY oi.order_id;

SELECT payment_id, order_id, payment_status, deposit_amount, remaining_amount FROM Payments;

PRINT 'DONE! Refresh browser now!';
