-- =============================================
-- Update Food Table - Thêm category và description
-- CHỈ THÊM fields, KHÔNG XOÁ gì
-- =============================================

USE SmartRestaurantDB;
GO

-- Tạo bảng Food nếu chưa có
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Food')
BEGIN
    CREATE TABLE Food (
        id BIGINT IDENTITY PRIMARY KEY,
        name NVARCHAR(100) NOT NULL,
        image VARCHAR(255),
        price FLOAT NOT NULL,
        category NVARCHAR(50) DEFAULT N'Tất cả',
        description NVARCHAR(500),
        created_at DATETIME DEFAULT GETDATE()
    );
    PRINT 'Created Food table with category and description';
END
ELSE
BEGIN
    -- Thêm category nếu chưa có
    IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Food') AND name = 'category')
    BEGIN
        ALTER TABLE Food ADD category NVARCHAR(50) DEFAULT N'Tất cả';
        PRINT 'Added category column to Food table';
    END
    
    -- Thêm description nếu chưa có
    IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Food') AND name = 'description')
    BEGIN
        ALTER TABLE Food ADD description NVARCHAR(500);
        PRINT 'Added description column to Food table';
    END
    
    -- Thêm created_at nếu chưa có
    IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Food') AND name = 'created_at')
    BEGIN
        ALTER TABLE Food ADD created_at DATETIME DEFAULT GETDATE();
        PRINT 'Added created_at column to Food table';
    END
END
GO

PRINT 'Food table update completed!';
GO
