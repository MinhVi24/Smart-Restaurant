-- In từng constraint ra riêng, không bị cắt
DECLARE @def NVARCHAR(MAX);

PRINT '=== ORDERS.status ===';
SELECT @def = CAST(definition AS NVARCHAR(MAX)) FROM sys.check_constraints WHERE name = 'CK__Orders__status__7A672E12';
PRINT @def;

PRINT '';
PRINT '=== RESERVATIONS.status (CK_Reservations_Status) ===';
SELECT @def = CAST(definition AS NVARCHAR(MAX)) FROM sys.check_constraints WHERE name = 'CK_Reservations_Status';
PRINT @def;

PRINT '';
PRINT '=== RESERVATIONS.status (CK_Reservations_Status_Updated) ===';
SELECT @def = CAST(definition AS NVARCHAR(MAX)) FROM sys.check_constraints WHERE name = 'CK_Reservations_Status_Updated';
PRINT @def;

PRINT '';
PRINT '=== TABLES.status ===';
SELECT @def = CAST(definition AS NVARCHAR(MAX)) FROM sys.check_constraints WHERE name = 'CK__Tables__status__6754599E';
PRINT @def;

PRINT '';
PRINT '=== PAYMENTS.payment_status ===';
SELECT @def = CAST(definition AS NVARCHAR(MAX)) FROM sys.check_constraints WHERE name = 'CK__Payments__paymen__1E6F845E';
PRINT @def;

PRINT '';
PRINT '=== PAYMENTS.payment_method ===';
SELECT @def = CAST(definition AS NVARCHAR(MAX)) FROM sys.check_constraints WHERE name = 'CK__Payments__paymen__0E6E26BF';
PRINT @def;
