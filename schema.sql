CREATE TABLE FarmersMarket (
    market_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(200) NOT NULL,
    schedule VARCHAR(100),
    contact_info VARCHAR(150)
);

CREATE TABLE Vendor (
    vendor_id INT PRIMARY KEY AUTO_INCREMENT,
    vendor_name VARCHAR(100) NOT NULL,
    contact_email VARCHAR(150),
    phone VARCHAR(30)
);

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(150),
    phone VARCHAR(30)
);

CREATE TABLE Product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    vendor_id INT NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    unit_price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL,
    CONSTRAINT fk_product_vendor
        FOREIGN KEY (vendor_id)
        REFERENCES Vendor(vendor_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE "Order" (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    pickup_market_id INT NOT NULL,
    order_date DATETIME NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_order_customer
        FOREIGN KEY (customer_id)
        REFERENCES Customer(customer_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_order_market
        FOREIGN KEY (pickup_market_id)
        REFERENCES FarmersMarket(market_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE MarketVendor (
    market_vendor_id INT PRIMARY KEY AUTO_INCREMENT,
    market_id INT NOT NULL,
    vendor_id INT NOT NULL,
    booth_number VARCHAR(20),
    CONSTRAINT fk_marketvendor_market
        FOREIGN KEY (market_id)
        REFERENCES FarmersMarket(market_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_marketvendor_vendor
        FOREIGN KEY (vendor_id)
        REFERENCES Vendor(vendor_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT uq_marketvendor_unique
        UNIQUE (market_id, vendor_id)
);

CREATE TABLE OrderItem (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price_at_purchase DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_orderitem_order
        FOREIGN KEY (order_id)
        REFERENCES "Order"(order_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_orderitem_product
        FOREIGN KEY (product_id)
        REFERENCES Product(product_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);
