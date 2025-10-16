import mysql.connector
def get_db_connection():
    connection = mysql.connector.connect(
        host = "127.0.0.1",
        user = "root",
        password  = "hung0335321015",
        database = "QLBanQuanAo"
    )
    return connection
def get_product_by_id(pid):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)  # trả dữ liệu dạng dict
    cursor.execute("SELECT * FROM products WHERE id = %s", (pid,))
    product = cursor.fetchone()
    cursor.close()
    conn.close()
    return product
