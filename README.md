# DBclassProject

MN MarketLink – Project Proposal

MN MarketLink is a database-driven application that connects Minnesotan farmers, vendors, and communities by digitizing farmer’s market information and product availability. Users can browse markets by location, view participating farmers, explore available products, and place pre-orders for pickup at markets.

Core Features:

• Browse a list of farmers markets in Minnesota
• View detailed information for a specific market
• Each market shows the participating vendors
• Each vendor has associated products they sell
• Search for products across all markets
• Users can place pre-orders with vendors for pickup
• Orders are recorded in the system and linked to vendors and users
• Supports multiple product categories
• Allows vendors to operate at multiple markets
• Allows users to view order history

2. ERD Structure (Your main deliverable)
ENTITIES:
FarmersMarket

market_id PK
name
location
schedule
contact_info

Vendor

vendor_id PK
vendor_name
contact_email
phone

MarketVendor

(relationship table for many-to-many)
market_id FK
vendor_id FK
booth_number

Product

product_id PK
vendor_id FK
product_name
category
unit_price
stock_quantity

Customer

customer_id PK
customer_name
email
phone

Order

order_id PK
customer_id FK
order_date
pickup_market_id FK
total_price

OrderItem

order_id FK
product_id FK
quantity
price_at_purchase

3. RELATIONSHIPS:

• One FarmersMarket has many Vendors, and one Vendor can attend many FarmersMarkets
This is implemented using MarketVendor

• One Vendor has many Products
(product.vendor_id FK)

• One Customer can have many Orders
(order.customer_id FK)

• One Order can contain many Products
(orderitem is the bridge)

• A FarmersMarket can have many Orders assigned for pickup
(order.pickup_market_id FK)
