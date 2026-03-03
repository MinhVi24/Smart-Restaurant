
USE SmartRestaurantDB;


/* Users với phân quyền */

CREATE TABLE Users (
    user_id INT IDENTITY PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    email VARCHAR(100),
    role VARCHAR(20) NOT NULL 
        CHECK (role IN ('CUSTOMER', 'STAFF', 'ADMIN')),
    status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE'
        CHECK (status IN ('ACTIVE', 'INACTIVE', 'BANNED')),
    created_at DATETIME NOT NULL DEFAULT GETDATE()


);


select * from Users

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


select * from Staff

CREATE TABLE Staff (
    staff_id INT IDENTITY PRIMARY KEY,
    user_id INT UNIQUE NOT NULL,
    full_name NVARCHAR(100) NOT NULL,
    position VARCHAR(30),
    status VARCHAR(20) DEFAULT 'ACTIVE'
        CHECK (status IN ('ACTIVE','OFF','RESIGNED')),

    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);


-- Chia ca / nhân sự 

CREATE TABLE Shifts (
    shift_id INT IDENTITY PRIMARY KEY,
    shift_name VARCHAR(50) NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL
);


 
 -- N-N -- 
CREATE TABLE Staff_Shifts (
    staff_id INT,
    shift_id INT,
    shift_date DATE NOT NULL,

    PRIMARY KEY (staff_id, shift_id, shift_date),
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id),
    FOREIGN KEY (shift_id) REFERENCES Shifts(shift_id)
);


select * from Staff_Shifts




-- Tạo Bàn , Chia Khu vucjwc 
CREATE TABLE Tables (
    table_id INT IDENTITY PRIMARY KEY,
    area NVARCHAR(50),
    capacity INT NOT NULL CHECK (capacity > 0),
    status VARCHAR(20) DEFAULT 'AVAILABLE'
        CHECK (status IN ('AVAILABLE','OCCUPIED','RESERVED'))
);



-- TẠO QUEUE & RESERVATION

CREATE TABLE Queue_Tickets (
    queue_id INT IDENTITY PRIMARY KEY,
    customer_id INT NULL,
    queue_date DATE NOT NULL,
    ticket_number INT NOT NULL,
    guest_count INT NOT NULL,
    priority VARCHAR(20) DEFAULT 'NORMAL'
        CHECK (priority IN ('NORMAL','VIP')),
    status VARCHAR(20) DEFAULT 'WAITING'
        CHECK (status IN ('WAITING','CALLED','CANCELLED')),
    created_time DATETIME DEFAULT GETDATE(),
    called_time DATETIME NULL,

    UNIQUE (queue_date, ticket_number),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);



CREATE TABLE Reservations (
    reservation_id INT IDENTITY PRIMARY KEY,
    customer_id INT NOT NULL,
    reservation_time DATETIME NOT NULL,
    guest_count INT NOT NULL,
    status VARCHAR(20) DEFAULT 'BOOKED'
        CHECK (status IN ('BOOKED','CANCELLED','COMPLETED')),
    created_at DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);




-- TẠO ORDER & PAYMENT

CREATE TABLE Orders (
    order_id INT IDENTITY PRIMARY KEY,
    customer_id INT,
    staff_id INT NOT NULL,
    table_id INT,
    order_time DATETIME DEFAULT GETDATE(),
    status VARCHAR(20) DEFAULT 'OPEN'
        CHECK (status IN ('OPEN','PAID','CANCELLED')),
    total_amount DECIMAL(12,2) DEFAULT 0,

    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id),
    FOREIGN KEY (table_id) REFERENCES Tables(table_id)
);




CREATE TABLE Order_Items (
    order_item_id INT IDENTITY PRIMARY KEY,
    order_id INT NOT NULL,
    menu_item_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    price DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (menu_item_id) REFERENCES Menu_Items(menu_item_id)
);



CREATE TABLE Payments (
    payment_id INT IDENTITY PRIMARY KEY,
    order_id INT UNIQUE NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    payment_method VARCHAR(20)
        CHECK (payment_method IN ('CASH','CARD','QR')),
    payment_time DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);


-- MENU – NGUYÊN LIỆU – KHO -- 

CREATE TABLE Menu_Items (
    menu_item_id INT IDENTITY PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'AVAILABLE'
);



CREATE TABLE Ingredients (
    ingredient_id INT IDENTITY PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    unit VARCHAR(20) NOT NULL
);


-- định mức nguyên liệu 
CREATE TABLE Menu_Ingredients (
    menu_item_id INT,
    ingredient_id INT,
    quantity_required DECIMAL(10,2) NOT NULL,

    PRIMARY KEY (menu_item_id, ingredient_id),
    FOREIGN KEY (menu_item_id) REFERENCES Menu_Items(menu_item_id),
    FOREIGN KEY (ingredient_id) REFERENCES Ingredients(ingredient_id)
);


-- supplier & inventory

CREATE TABLE Suppliers (
    supplier_id INT IDENTITY PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    certification NVARCHAR(100)
);


CREATE TABLE Inventory (
    inventory_id INT IDENTITY PRIMARY KEY,
    ingredient_id INT NOT NULL,
    supplier_id INT,
    quantity DECIMAL(10,2) NOT NULL,
    expiry_date DATE,
    status VARCHAR(20)
        CHECK (status IN ('GOOD','LOW','EXPIRED')),
    last_updated DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (ingredient_id) REFERENCES Ingredients(ingredient_id),
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
);




-- Bảng lưu dữ liệu RBL

CREATE TABLE Daily_Stats (
    stat_date DATE PRIMARY KEY,
    guest_count INT,
    total_revenue DECIMAL(14,2),
    peak_flag BIT
);


CREATE TABLE Predictions (
    prediction_id INT IDENTITY PRIMARY KEY,
    prediction_date DATE NOT NULL,
    predicted_guest_count INT,
    predicted_revenue DECIMAL(14,2),
    method VARCHAR(50),
    created_at DATETIME DEFAULT GETDATE()
);


SELECT name FROM sys.tables;


