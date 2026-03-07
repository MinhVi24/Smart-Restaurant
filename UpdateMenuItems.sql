-- =============================================
-- Update Menu_Items table to support options
-- =============================================

USE SmartRestaurantDB;
GO

-- 1. Add new columns
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Menu_Items') AND name = 'description')
    ALTER TABLE Menu_Items ADD description NVARCHAR(500) NULL;

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Menu_Items') AND name = 'category')
    ALTER TABLE Menu_Items ADD category NVARCHAR(50) NULL;

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Menu_Items') AND name = 'image_url')
    ALTER TABLE Menu_Items ADD image_url NVARCHAR(500) NULL;

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Menu_Items') AND name = 'options')
    ALTER TABLE Menu_Items ADD options NVARCHAR(MAX) NULL;

PRINT 'Added new columns to Menu_Items table';
GO

-- 2. Update existing items with sample data
UPDATE Menu_Items SET 
    category = N'Khai vị',
    description = N'Món khai vị cao cấp',
    image_url = 'https://images.unsplash.com/photo-1606787366850-de6330128bfc?w=800&q=80'
WHERE name LIKE N'%Sò Điệp%' OR name LIKE N'%Gan Ngỗng%' OR name LIKE N'%Salad%';

UPDATE Menu_Items SET 
    category = N'Món chính',
    description = N'Món chính đặc sắc',
    image_url = 'https://images.unsplash.com/photo-1558030006-450675393462?w=800&q=80'
WHERE name LIKE N'%Bò%' OR name LIKE N'%Tôm%' OR name LIKE N'%Cá%' OR name LIKE N'%Vịt%';

UPDATE Menu_Items SET 
    category = N'Tráng miệng',
    description = N'Tráng miệng ngọt ngào',
    image_url = 'https://images.unsplash.com/photo-1571877227200-a0d98ea607e9?w=800&q=80'
WHERE name LIKE N'%Tiramisu%' OR name LIKE N'%Crème%' OR name LIKE N'%Kem%';

UPDATE Menu_Items SET 
    category = N'Đồ uống',
    description = N'Đồ uống cao cấp',
    image_url = 'https://images.unsplash.com/photo-1510812431401-41d2bd2722f3?w=800&q=80'
WHERE name LIKE N'%Rượu%' OR name LIKE N'%Champagne%' OR name LIKE N'%Trà%' OR name LIKE N'%Nước%';

PRINT 'Updated existing items with categories and images';
GO

-- 3. Add sample items with options
DELETE FROM Menu_Items WHERE name LIKE N'%[TEST]%';

INSERT INTO Menu_Items (name, description, price, category, status, options, image_url) VALUES
(N'Foie Gras Poêlé', N'Gan ngỗng Pháp áp chảo với sốt vang đỏ và bánh mì nướng giòn.', 850000, N'Khai vị', 'AVAILABLE', 
 '{"label":"Phụ Kiện Kèm Theo","options":["Sốt Nấm","Sốt Vang Đỏ"],"default":1}',
 'https://images.unsplash.com/photo-1606787366850-de6330128bfc?w=800&q=80'),

(N'Wagyu A5 Miyazaki', N'Marble Score 12, kết cấu mềm mại như bơ với hương thơm đặc trưng của hạt dẻ.', 3800000, N'Món chính', 'AVAILABLE',
 '{"label":"Trọng Lượng","options":["200g","300g","500g"],"default":1}',
 'https://images.unsplash.com/photo-1558030006-450675393462?w=800&q=80'),

(N'Black Angus Ribeye', N'Bò ăn ngũ cốc 200 ngày từ vùng Úc, hương vị đậm đà, độ ngọt thịt vượt trội.', 1450000, N'Món chính', 'AVAILABLE',
 '{"label":"Độ Chín","options":["Medium Rare","Medium","Well Done"],"default":0}',
 'https://images.unsplash.com/photo-1600891964092-4316c288032e?w=800&q=80');

PRINT 'Added sample items with options';
GO

-- 4. Verify
SELECT 
    menu_item_id,
    name,
    category,
    price,
    options,
    status
FROM Menu_Items
ORDER BY category, name;

PRINT 'Update completed successfully!';
GO
