# Install MySQL connector (if not installed)
# pip install mysql-connector-python

import mysql.connector
from tkinter import *
from tkinter import messagebox
import datetime

# Function to establish database connection
def connect_db():
    return mysql.connector.connect(
        host="localhost", user="root", password="", database="inventory_sales_db"
    )

# Function to add stock
def add_stock():
    name, qty, price = entry_name.get(), entry_qty.get(), entry_price.get()
    if name and qty.isdigit() and price.replace('.', '', 1).isdigit():
        try:
            conn = connect_db()
            cur = conn.cursor()
            cur.execute("INSERT INTO stock (name, quantity, price) VALUES (%s, %s, %s)", (name, int(qty), float(price)))
            conn.commit()
            cur.close()
            conn.close()
            fetch_stock()
        except Exception as e:
            messagebox.showerror("DB Error", str(e))
    else:
        messagebox.showerror("Input Error", "Please enter valid numeric values for quantity and price.")

# Function to record a sale
def record_sale():
    try:
        item_id, qty = entry_id.get(), entry_sale_qty.get()
        if item_id.isdigit() and qty.isdigit():
            item_id, qty = int(item_id), int(qty)
            conn = connect_db()
            cur = conn.cursor()
            cur.execute("SELECT quantity, price FROM stock WHERE id=%s", (item_id,))
            stock = cur.fetchone()
            
            if stock and stock[0] >= qty:
                total = qty * stock[1]
                cur.execute("INSERT INTO sales (item_id, quantity, sale_date, total_price) VALUES (%s, %s, %s, %s)",
                            (item_id, qty, datetime.date.today(), total))
                cur.execute("UPDATE stock SET quantity = quantity - %s WHERE id = %s", (qty, item_id))
                conn.commit()
                fetch_stock()
                fetch_sales()
            else:
                messagebox.showerror("Error", "Insufficient stock.")
                
            cur.close()
            conn.close()
        else:
            messagebox.showerror("Input Error", "Please enter valid numeric values.")
    except Exception as e:
        messagebox.showerror("DB Error", str(e))

# Function to fetch stock data
def fetch_stock():
    listbox_stock.delete(0, END)
    try:
        conn = connect_db()
        cur = conn.cursor()
        cur.execute("SELECT * FROM stock")
        for item in cur.fetchall():
            listbox_stock.insert(END, f"{item[0]} - {item[1]} - Qty: {item[2]} - ${item[3]}")
        cur.close()
        conn.close()
    except Exception as e:
        messagebox.showerror("DB Error", str(e))

# Function to fetch sales data
def fetch_sales():
    listbox_sales.delete(0, END)
    try:
        conn = connect_db()
        cur = conn.cursor()
        cur.execute("SELECT * FROM sales")
        for item in cur.fetchall():
            listbox_sales.insert(END, f"Sale ID: {item[0]} - Item ID: {item[1]} - Qty: {item[2]} - ${item[4]} - Date: {item[3]}")
        cur.close()
        conn.close()
    except Exception as e:
        messagebox.showerror("DB Error", str(e))

# UI Setup
root = Tk()
root.title("Inventory App")
root.geometry("600x500")

Label(root, text="Name").pack()
entry_name = Entry(root)
entry_name.pack()

Label(root, text="Quantity").pack()
entry_qty = Entry(root)
entry_qty.pack()

Label(root, text="Price").pack()
entry_price = Entry(root)
entry_price.pack()

Button(root, text="Add Stock", command=add_stock).pack()

Label(root, text="Product ID").pack()
entry_id = Entry(root)
entry_id.pack()

Label(root, text="Sell Qty").pack()
entry_sale_qty = Entry(root)
entry_sale_qty.pack()

Button(root, text="Record Sale", command=record_sale).pack()

listbox_stock = Listbox(root, width=80, height=8)
listbox_stock.pack()

listbox_sales = Listbox(root, width=80, height=8)
listbox_sales.pack()

fetch_stock()
fetch_sales()

root.mainloop()
