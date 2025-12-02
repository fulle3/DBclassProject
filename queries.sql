-- Main application queries for MN MarketLink

--------------------------------------------------
-- 1. Browse all farmers markets (basic list)
--------------------------------------------------
SELECT
    market_id,
    name,
    location,
    schedule
FROM FarmersMarket
ORDER BY name;

--------------------------------------------------
-- 2. View details for a specific market, including vendors
-- :marketId is a placeholder for your application parameter
--------------------------------------------------
SELECT
    fm.market_id,
    fm.name AS market_name,
    fm.location,
    fm.schedule,
    v.vendor_id,
    v.vendor_name,
    mv.booth_number
FROM FarmersMarket fm
JOIN MarketVendor mv ON fm.market_id = mv.market_id
JOIN Vendor v ON mv.vendor_id = v.vendor_id
WHERE fm.market_id = :marketId
ORDER BY v.vendor_name;

--------------------------------------------------
-- 3. View all products available at a given market (through vendors)
-- Shows which vendor sells each product
--------------------------------------------------
SELECT
    fm.market_id,
    fm.name AS market_name,
    v.vendor_id,
    v.vendor_name,
    p.product_id,
    p.product_name,
    p.category,
    p.unit_price,
    p.stock_quantity
FROM FarmersMarket fm
JOIN MarketVendor mv ON fm.market_id = mv.market_id
JOIN Vendor v ON mv.vendor_id = v.vendor_id
JOIN Product p ON v.vendor_id = p.vendor_id
WHERE fm.market_id = :marketId
ORDER BY v.vendor_name, p.product_name;

--------------------------------------------------
-- 4. Search for products across all markets by name or category
-- :searchTerm will be something like '%apple%' from the UI
--------------------------------------------------
SELECT DISTINCT
    p.product_id,
    p.product_name,
    p.category,
    p.unit_price,
    v.vendor_id,
    v.vendor_name,
    fm.market_id,
    fm.name AS market_name,
    fm.location
FROM Product p
JOIN Vendor v ON p.vendor_id = v.vendor_id
JOIN MarketVendor mv ON v.vendor_id = mv.vendor_id
JOIN FarmersMarket fm ON mv.market_id = fm.market_id
WHERE (p.product_name LIKE :searchTerm
       OR p.category LIKE :searchTerm)
ORDER BY p.product_name;

--------------------------------------------------
-- 5. Get all products sold by a specific vendor
--------------------------------------------------
SELECT
    v.vendor_id,
    v.vendor_name,
    p.product_id,
    p.product_name,
    p.category,
    p.unit_price,
    p.stock_quantity
FROM Vendor v
JOIN Product p ON v.vendor_id = p.vendor_id
WHERE v.vendor_id = :vendorId
ORDER BY p.product_name;

--------------------------------------------------
-- 6. Get a vendor's market schedule (which markets they attend)
--------------------------------------------------
SELECT
    v.vendor_id,
    v.vendor_name,
    fm.market_id,
    fm.name AS market_name,
    fm.location,
    fm.schedule,
    mv.booth_number
FROM Vendor v
JOIN MarketVendor mv ON v.vendor_id = mv.vendor_id
JOIN FarmersMarket fm ON mv.market_id = fm.market_id
WHERE v.vendor_id = :vendorId
ORDER BY fm.name;

--------------------------------------------------
-- 7. Get a customer's past orders with totals
--------------------------------------------------
SELECT
    o.order_id,
    o.order_date,
    o.total_price,
    fm.name AS pickup_market_name,
    fm.location
FROM `Order` o
JOIN FarmersMarket fm ON o.pickup_market_id = fm.market_id
WHERE o.customer_id = :customerId
ORDER BY o.order_date DESC;

--------------------------------------------------
-- 8. Get full details of a single order (line items)
--------------------------------------------------
SELECT
    o.order_id,
    o.order_date,
    c.customer_name,
    fm.name AS pickup_market_name,
    p.product_name,
    oi.quantity,
    oi.price_at_purchase,
    (oi.quantity * oi.price_at_purchase) AS line_total
FROM `Order` o
JOIN Customer c ON o.customer_id = c.customer_id
JOIN FarmersMarket fm ON o.pickup_market_id = fm.market_id
JOIN OrderItem oi ON o.order_id = oi.order_id
JOIN Product p ON oi.product_id = p.product_id
WHERE o.order_id = :orderId
ORDER BY p.product_name;

--------------------------------------------------
-- 9. Example: top-selling products by quantity (simple report)
--------------------------------------------------
SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM OrderItem oi
JOIN Product p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity_sold DESC;
