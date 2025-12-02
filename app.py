from flask import Flask, render_template, request, redirect, url_for, flash
import mysql.connector
from mysql.connector import Error

app = Flask(__name__)
app.secret_key = "change_this_secret"

# NEED TO UPDATE
DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "your_password_here",
    "database": "mn_marketlink"
}


def get_db_connection():
    return mysql.connector.connect(**DB_CONFIG)


@app.route("/")
def index():
    return redirect(url_for("list_markets"))


@app.route("/markets")
def list_markets():
    db = get_db_connection()
    cursor = db.cursor(dictionary=True)
    cursor.execute("""
        SELECT market_id, name, location, schedule
        FROM FarmersMarket
        ORDER BY name;
    """)
    markets = cursor.fetchall()
    cursor.close()
    db.close()
    return render_template("markets.html", markets=markets)


@app.route("/markets/<int:market_id>")
def market_detail(market_id):
    db = get_db_connection()
    cursor = db.cursor(dictionary=True)

    # Market info
    cursor.execute("""
        SELECT market_id, name, location, schedule
        FROM FarmersMarket
        WHERE market_id = %s;
    """, (market_id,))
    market = cursor.fetchone()

    # Vendors at this market
    cursor.execute("""
        SELECT v.vendor_id, v.vendor_name, mv.booth_number
        FROM MarketVendor mv
        JOIN Vendor v ON mv.vendor_id = v.vendor_id
        WHERE mv.market_id = %s
        ORDER BY v.vendor_name;
    """, (market_id,))
    vendors = cursor.fetchall()

    cursor.close()
    db.close()
    return render_template("market_detail.html", market=market, vendors=vendors)


@app.route("/search")
def search_products():
    q = request.args.get("q", "").strip()

    results = []
    if q:
        db = get_db_connection()
        cursor = db.cursor(dictionary=True)
        like = f"%{q}%"
        cursor.execute("""
            SELECT DISTINCT
                p.product_id,
                p.product_name,
                p.category,
                p.unit_price,
                v.vendor_name,
                fm.name AS market_name,
                fm.location
            FROM Product p
            JOIN Vendor v ON p.vendor_id = v.vendor_id
            JOIN MarketVendor mv ON v.vendor_id = mv.vendor_id
            JOIN FarmersMarket fm ON mv.market_id = fm.market_id
            WHERE p.product_name LIKE %s OR p.category LIKE %s
            ORDER BY p.product_name;
        """, (like, like))
        results = cursor.fetchall()
        cursor.close()
        db.close()

    return render_template("search.html", q=q, results=results)


@app.route("/order", methods=["GET", "POST"])
def place_order():
    db = get_db_connection()
    cursor = db.cursor(dictionary=True)

    if request.method == "POST":
        customer_id = int(request.form["customer_id"])
        market_id = int(request.form["market_id"])
        product_id = int(request.form["product_id"])
        quantity = int(request.form["quantity"])

        try:
            # Begin transaction explicitly
            db.start_transaction()

            # Get product price
            cursor.execute("""
                SELECT unit_price
                FROM Product
                WHERE product_id = %s;
            """, (product_id,))
            row = cursor.fetchone()
            if not row:
                raise ValueError("Product not found")

            unit_price = float(row["unit_price"])
            total_price = unit_price * quantity

            # Insert into Order
            cursor.execute("""
                INSERT INTO `Order` (customer_id, pickup_market_id, order_date, total_price)
                VALUES (%s, %s, NOW(), %s);
            """, (customer_id, market_id, total_price))
            order_id = cursor.lastrowid

            # Insert into OrderItem
            cursor.execute("""
                INSERT INTO OrderItem (order_id, product_id, quantity, price_at_purchase)
                VALUES (%s, %s, %s, %s);
            """, (order_id, product_id, quantity, unit_price))

            # Commit transaction
            db.commit()
            flash(f"Order #{order_id} placed successfully!", "success")
            return redirect(url_for("place_order"))

        except Error as e:
            db.rollback()
            flash(f"Error placing order: {e}", "error")
        except Exception as e:
            db.rollback()
            flash(f"Error placing order: {e}", "error")

    # GET: load dropdown data
    cursor.execute("SELECT customer_id, customer_name FROM Customer ORDER BY customer_name;")
    customers = cursor.fetchall()

    cursor.execute("SELECT market_id, name FROM FarmersMarket ORDER BY name;")
    markets = cursor.fetchall()

    cursor.execute("""
        SELECT product_id, product_name
        FROM Product
        ORDER BY product_name;
    """)
    products = cursor.fetchall()

    cursor.close()
    db.close()

    return render_template("order.html",
                           customers=customers,
                           markets=markets,
                           products=products)


if __name__ == "__main__":
    app.run(debug=True)
