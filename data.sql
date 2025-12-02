-- Sample data for MN MarketLink

-- Clear existing data (optional, use if needed)
-- DELETE FROM OrderItem;
-- DELETE FROM 'Order';
-- DELETE FROM MarketVendor;
-- DELETE FROM Product;
-- DELETE FROM Customer;
-- DELETE FROM Vendor;
-- DELETE FROM FarmersMarket;

-- 10 Farmers Markets
INSERT INTO FarmersMarket (market_id, name, location, schedule, contact_info) VALUES
(1, 'Minneapolis Downtown Farmers Market', 'Minneapolis, MN', 'Sat 7am-1pm, May-Oct', 'info@mplsdowntownfm.org'),
(2, 'St. Paul Lowertown Market', 'St. Paul, MN', 'Sat 8am-1pm, May-Oct', 'contact@lowertownmarket.org'),
(3, 'Duluth Lakefront Market', 'Duluth, MN', 'Sun 9am-2pm, Jun-Sep', 'hello@duluthlakefront.org'),
(4, 'Rochester Riverside Market', 'Rochester, MN', 'Sat 8am-12pm, May-Oct', 'info@rochesterriverside.org'),
(5, 'Mankato River Valley Market', 'Mankato, MN', 'Sat 8am-12pm, Jun-Oct', 'contact@rivervalleymarket.org'),
(6, 'St. Cloud Granite City Market', 'St. Cloud, MN', 'Sat 8am-12pm, May-Sep', 'info@granitecitymarket.org'),
(7, 'Moorhead Red River Market', 'Moorhead, MN', 'Sun 10am-2pm, Jun-Sep', 'hello@redrivermarket.org'),
(8, 'Bemidji Lakes Area Market', 'Bemidji, MN', 'Sat 9am-1pm, Jun-Sep', 'contact@bemidjimarket.org'),
(9, 'Winona Bluffside Market', 'Winona, MN', 'Sat 8am-12pm, May-Oct', 'info@winonabluffmarket.org'),
(10, 'Brainerd Northwoods Market', 'Brainerd, MN', 'Sat 9am-1pm, Jun-Sep', 'hello@northwoodsmarket.org');

-- 20 Vendors (farmers)
INSERT INTO Vendor (vendor_id, vendor_name, contact_email, phone) VALUES
(1, 'North Shore Produce', 'northshore@farmersmn.com', '218-555-0001'),
(2, 'Prairie Sun Farms', 'prairiesun@farmersmn.com', '507-555-0002'),
(3, 'Twin Cities Greens', 'tcgreens@farmersmn.com', '612-555-0003'),
(4, 'River Valley Dairy', 'rivervalley@farmersmn.com', '507-555-0004'),
(5, 'Iron Range Meats', 'ironrange@farmersmn.com', '218-555-0005'),
(6, 'Lakeside Orchards', 'lakeside@farmersmn.com', '218-555-0006'),
(7, 'Grassland Grains', 'grassland@farmersmn.com', '320-555-0007'),
(8, 'Midtown Honey Co.', 'midtownhoney@farmersmn.com', '612-555-0008'),
(9, 'Morning Meadow Eggs', 'meadoweggs@farmersmn.com', '651-555-0009'),
(10, 'Northwoods Mushrooms', 'northwoods@farmersmn.com', '218-555-0010'),
(11, 'Cedar Grove Organics', 'cedargrove@farmersmn.com', '763-555-0011'),
(12, 'Blue Sky Berries', 'bluesky@farmersmn.com', '507-555-0012'),
(13, 'Sunrise Veggies', 'sunrise@farmersmn.com', '651-555-0013'),
(14, 'Heritage Pork Farm', 'heritagepork@farmersmn.com', '507-555-0014'),
(15, 'Maple Ridge Syrup', 'mapleridge@farmersmn.com', '218-555-0015'),
(16, 'Golden Fields Wheat', 'goldenfields@farmersmn.com', '320-555-0016'),
(17, 'City Roots Microgreens', 'cityroots@farmersmn.com', '612-555-0017'),
(18, 'Lakeview Flowers & Herbs', 'lakeview@farmersmn.com', '218-555-0018'),
(19, 'Elm Street Cider', 'elmstreet@farmersmn.com', '507-555-0019'),
(20, 'Prairie Harvest Veg', 'prairieharvest@farmersmn.com', '507-555-0020');

-- 50 Products (unique)
INSERT INTO Product (product_id, vendor_id, product_name, category, unit_price, stock_quantity) VALUES
(1, 1, 'Red Potatoes (5 lb bag)', 'Vegetables', 4.50, 40),
(2, 1, 'Carrots (2 lb bunch)', 'Vegetables', 3.00, 50),
(3, 2, 'Sweet Corn (dozen ears)', 'Vegetables', 6.50, 60),
(4, 2, 'Butternut Squash', 'Vegetables', 2.75, 35),
(5, 3, 'Mixed Salad Greens (1 lb)', 'Vegetables', 5.00, 45),
(6, 3, 'Kale Bunch', 'Vegetables', 3.50, 30),
(7, 4, 'Whole Milk (1 gal)', 'Dairy', 4.25, 25),
(8, 4, 'Cheddar Cheese (8 oz)', 'Dairy', 5.50, 40),
(9, 5, 'Ground Beef (1 lb)', 'Meat', 7.99, 30),
(10, 5, 'Pork Chops (1 lb)', 'Meat', 6.99, 25),
(11, 6, 'Honeycrisp Apples (3 lb bag)', 'Fruit', 7.50, 50),
(12, 6, 'Apple Cider (half gallon)', 'Beverages', 4.75, 35),
(13, 7, 'Whole Wheat Flour (5 lb)', 'Grains', 6.00, 40),
(14, 7, 'Rolled Oats (2 lb)', 'Grains', 4.00, 30),
(15, 8, 'Raw Wildflower Honey (1 lb)', 'Sweeteners', 9.00, 25),
(16, 8, 'Comb Honey (8 oz)', 'Sweeteners', 7.50, 20),
(17, 9, 'Dozen Large Eggs', 'Eggs', 4.00, 60),
(18, 9, 'Dozen Free Range Eggs', 'Eggs', 5.50, 40),
(19, 10, 'Oyster Mushrooms (1/2 lb)', 'Vegetables', 6.50, 25),
(20, 10, 'Shiitake Mushrooms (1/2 lb)', 'Vegetables', 7.00, 20),
(21, 11, 'Organic Romaine Lettuce', 'Vegetables', 3.25, 30),
(22, 11, 'Organic Tomatoes (1 lb)', 'Vegetables', 4.75, 35),
(23, 12, 'Blueberries (pint)', 'Fruit', 5.50, 40),
(24, 12, 'Strawberries (quart)', 'Fruit', 6.00, 30),
(25, 13, 'Green Beans (1 lb)', 'Vegetables', 3.50, 30),
(26, 13, 'Bell Peppers (3 pack)', 'Vegetables', 4.25, 35),
(27, 14, 'Bacon (1 lb)', 'Meat', 8.50, 25),
(28, 14, 'Sausage Links (1 lb)', 'Meat', 7.25, 25),
(29, 15, 'Maple Syrup (16 oz)', 'Sweeteners', 10.00, 30),
(30, 15, 'Maple Candy (6 pcs)', 'Sweeteners', 5.00, 20),
(31, 16, 'Bread Flour (5 lb)', 'Grains', 6.25, 30),
(32, 16, 'Cornmeal (2 lb)', 'Grains', 4.25, 25),
(33, 17, 'Microgreens Mix (4 oz)', 'Vegetables', 5.75, 30),
(34, 17, 'Sunflower Shoots (4 oz)', 'Vegetables', 5.25, 25),
(35, 18, 'Basil Bunch', 'Herbs', 2.50, 30),
(36, 18, 'Fresh Cut Flowers (bouquet)', 'Flowers', 12.00, 20),
(37, 19, 'Dry Cider (750 ml)', 'Beverages', 11.00, 15),
(38, 19, 'Sweet Cider (750 ml)', 'Beverages', 10.00, 18),
(39, 20, 'Heirloom Tomatoes (1 lb)', 'Vegetables', 5.25, 30),
(40, 20, 'Zucchini (1 lb)', 'Vegetables', 3.00, 35),
(41, 3, 'Spinach (8 oz bag)', 'Vegetables', 4.00, 25),
(42, 6, 'Gala Apples (3 lb bag)', 'Fruit', 6.50, 30),
(43, 7, 'Multigrain Bread Mix (2 lb)', 'Grains', 5.75, 20),
(44, 8, 'Creamed Honey (12 oz)', 'Sweeteners', 8.75, 18),
(45, 11, 'Organic Cucumbers (each)', 'Vegetables', 1.75, 40),
(46, 12, 'Raspberries (half pint)', 'Fruit', 4.75, 25),
(47, 13, 'Sweet Onions (2 lb)', 'Vegetables', 3.25, 30),
(48, 15, 'Maple Sugar (8 oz)', 'Sweeteners', 7.25, 15),
(49, 17, 'Pea Shoots (4 oz)', 'Vegetables', 5.00, 20),
(50, 20, 'Winter Squash (each)', 'Vegetables', 3.75, 25);

-- MarketVendor: which vendor sells at which market
INSERT INTO MarketVendor (market_vendor_id, market_id, vendor_id, booth_number) VALUES
(1, 1, 1, 'A1'),
(2, 1, 3, 'A2'),
(3, 1, 8, 'B1'),
(4, 1, 9, 'B2'),
(5, 2, 2, 'C1'),
(6, 2, 4, 'C2'),
(7, 2, 13, 'D1'),
(8, 3, 6, 'E1'),
(9, 3, 12, 'E2'),
(10, 3, 19, 'F1'),
(11, 4, 5, 'G1'),
(12, 4, 14, 'G2'),
(13, 5, 7, 'H1'),
(14, 5, 16, 'H2'),
(15, 6, 11, 'J1'),
(16, 6, 17, 'J2'),
(17, 7, 10, 'K1'),
(18, 7, 18, 'K2'),
(19, 8, 15, 'L1'),
(20, 8, 20, 'L2');

-- A few customers
INSERT INTO Customer (customer_id, customer_name, email, phone) VALUES
(1, 'Alex Johnson', 'alex.johnson@example.com', '612-555-1010'),
(2, 'Maria Lopez', 'maria.lopez@example.com', '651-555-2020'),
(3, 'Ethan Smith', 'ethan.smith@example.com', '507-555-3030');

-- A few sample orders (pickup at markets)
INSERT INTO `Order` (order_id, customer_id, pickup_market_id, order_date, total_price) VALUES
(1, 1, 1, '2025-07-10 09:30:00', 19.25),
(2, 2, 2, '2025-07-11 10:15:00', 27.50),
(3, 1, 3, '2025-07-12 09:45:00', 15.50),
(4, 3, 4, '2025-07-12 11:00:00', 32.75);

-- Order items
INSERT INTO OrderItem (order_item_id, order_id, product_id, quantity, price_at_purchase) VALUES
(1, 1, 1, 1, 4.50),
(2, 1, 11, 1, 7.50),
(3, 1, 17, 2, 4.00),
(4, 2, 7, 1, 4.25),
(5, 2, 8, 2, 5.50),
(6, 2, 15, 1, 9.00),
(7, 3, 23, 1, 5.50),
(8, 3, 19, 1, 6.50),
(9, 4, 9, 2, 7.99),
(10, 4, 27, 1, 8.50),
(11, 4, 29, 1, 10.00);
