from flask import Blueprint, render_template, request, redirect, url_for, session, jsonify
from database.connect import get_connect

cart_bp = Blueprint('cart_bp', __name__)

# Trang giỏ hàng
@cart_bp.route('/cart')
def cart():
    ma_kh = session.get('id')
    conn = get_connect()
    if not ma_kh:
        return redirect(url_for('login_module.login'))
    cursor = conn.cursor(dictionary=True)
    cursor.execute("""
            SELECT gh.*, sp.*, 
                   spm.url_anh1
            FROM GioHang gh
            JOIN SanPham sp ON gh.MaSP = sp.MaSP
            LEFT JOIN SanPhamMau spm 
                ON sp.MaSP = spm.id_sanpham AND spm.tenmau = gh.MauSacDaChon
            WHERE gh.MaKH = %s
        """, (ma_kh,))

    cart_items = cursor.fetchall()

    for item in cart_items:
        item['sizes'] = [c.strip() for c in item.get('Size', '').split(',') if c.strip()]
        item['colors'] = [c.strip() for c in item.get('MauSac', '').split(',') if c.strip()]
        item['selected_image'] = item['url_anh1'] or item['HinhAnh']

    #Debug kiểm tra sai link ảnh
    for item in cart_items:
        print(item['MaSP'], item['selected_image'])

    total_price = round(sum((item['Gia'] * (100 - item['Discount']) / 100) * item['SoLuong'] for item in cart_items))
    cursor.close()
    conn.close()
    return render_template('cart.html', cart_items= cart_items, total_price= total_price)

# Thêm sản phẩm từ trang details
@cart_bp.route('/add-no-reload', methods=['POST'])
def add_cart_no_reload():
    try:
        data = request.get_json()  # nhận dữ liệu JSON từ fetch
        ma_sp = int(data.get('ma_sp'))
        so_luong = int(data.get('so_luong', 1))
        mau = data.get('mau')  # thêm màu
        size = data.get('size')
        ma_kh = session.get('id')

        if not ma_kh:
            return jsonify({'error': 'not_logged_in'}), 401

        # Lấy ttin sp từ bảng Product
        conn = get_connect()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM QLBanQuanAo.SanPham WHERE MaSP = %s", (ma_sp,))
        product = cursor.fetchone()
        if not product:
            return jsonify({'error': 'invalid_product'}), 404

        cursor.execute("""
                SELECT * FROM QLBanQuanAo.GioHang 
                WHERE MaSP = %s AND MaKH = %s
                AND MauSacDaChon LIKE %s AND KichCoDaChon LIKE %s
                """, (ma_sp, ma_kh, mau, size))
        product = cursor.fetchone()
        if not product:
            # Thêm đơn hàng
            sqladd = """
                INSERT INTO QLBanQuanAo.GioHang
                (MaKH, MaSP, SoLuong, MauSacDaChon, KichCoDaChon)
                VALUES (%s, %s, %s, %s, %s)
            """
            cursor.execute(sqladd, (ma_kh, ma_sp, so_luong, mau, size))
        else:
            sqlupdate = """
                    UPDATE QLBanQuanAo.GioHang
                    SET SoLuong = SoLuong + %s
                    WHERE MaKH = %s AND MaSP = %s
                    AND (MauSacDaChon <=> %s) AND (KichCoDaChon <=> %s)
                """
            cursor.execute(sqlupdate, (so_luong, ma_kh, ma_sp, mau, size))
        conn.commit()
        cursor.close()
        conn.close()
        return jsonify({'success': True})
    except Exception as e:
        print("Error adding to cart:", e)
        return jsonify({'error': 'server_error'}), 500

# Xóa sản phẩm khỏi giỏ
@cart_bp.route('/remove-from-cart', methods = ['POST'])
def remove_from_cart():
    maKH = session.get('id')

    data = request.get_json()
    maSP = data.get('maSP')
    mau = data.get('mau')
    size = data.get('size')

    conn = get_connect()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("""
        DELETE FROM QLBanQuanAo.GioHang
        WHERE MaSP = %s AND MaKH = %s
        AND MauSacDaChon = %s AND KichCoDaChon = %s
        """, (maSP, maKH, mau, size))
    conn.commit()
    return jsonify({"success": True})

# Xóa toàn bộ giỏ hàng
@cart_bp.route('/clear-cart')
def clear_cart():
    maKH = session.get('id')
    conn = get_connect()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("""
        DELETE FROM QLBanQuanAo.GioHang
        WHERE MaKH = %s
        """, (maKH,))
    conn.commit()
    return redirect(url_for('cart_bp.cart'))

#update số lượng
@cart_bp.route('/update-cart', methods=['POST'])
def update_cart():
    try:
        data = request.get_json()  # nhận dữ liệu JSON từ fetch
        ma_sp = int(data.get('MaSP'))
        so_luong = int(data.get('SoLuong', 1))
        mau = data.get('MauSacDaChon')
        size = data.get('KichCoDaChon')
        ma_kh = session.get('id')

        if not ma_kh:
            return jsonify({'error': 'not_logged_in'}), 401

        # Lấy ttin sp từ bảng Product
        conn = get_connect()
        cursor = conn.cursor(dictionary=True)

        cursor.execute("""
        SELECT * from GioHang 
        WHERE MaSP = %s AND MaKH = %s
        AND MauSacDaChon = %s AND KichCoDaChon = %s
        """, (ma_sp, ma_kh, mau, size))
        product = cursor.fetchone()
        if product:
            sqlupdate = """
                UPDATE GioHang
                SET SoLuong = %s
                WHERE MaSP = %s AND MaKH = %s
                AND MauSacDaChon = %s AND KichCoDaChon = %s;
            """
            cursor.execute(sqlupdate, (so_luong, ma_sp, ma_kh, mau, size))
            conn.commit()
            cursor.close()
            conn.close()
            return jsonify({'success': True})
        else:
            return jsonify({'error': 'invalid_number'}), 408
    except Exception as e:
        print("Error adding to cart:", e)
        return jsonify({'error': 'server_error'}), 500

@cart_bp.route('/update-cart-item-option', methods=['POST'])
def update_cart_item_option():
    try:
        data = request.get_json()
        ma_kh = session.get('id')
        old_sp = int(data.get('old_ma_sp'))
        new_sp = int(data.get('new_ma_sp', old_sp))
        old_mau = data.get('old_mau')
        old_size = data.get('old_size')
        new_mau = data.get('new_mau')
        new_size = data.get('new_size')
        so_luong = int(data.get('so_luong', 1))

        if not ma_kh:
            return jsonify({'error': 'not_logged_in'}), 401

        conn = get_connect()
        cursor = conn.cursor(dictionary=True)

        # Xóa item cũ trong giỏ
        cursor.execute("""
            DELETE FROM QLBanQuanAo.GioHang
            WHERE MaSP = %s AND MaKH = %s
            AND MauSacDaChon = %s AND KichCoDaChon = %s
        """, (old_sp, ma_kh, old_mau, old_size))

        # Thêm hoặc cộng dồn item mới
        cursor.execute("""
            SELECT * FROM QLBanQuanAo.GioHang
            WHERE MaSP = %s AND MaKH = %s
            AND MauSacDaChon = %s AND KichCoDaChon = %s
        """, (new_sp, ma_kh, new_mau, new_size))
        existed = cursor.fetchone()

        if existed:
            cursor.execute("""
                UPDATE QLBanQuanAo.GioHang
                SET SoLuong = SoLuong + %s
                WHERE MaSP = %s AND MaKH = %s
                AND MauSacDaChon = %s AND KichCoDaChon = %s
            """, (so_luong, new_sp, ma_kh, new_mau, new_size))
        else:
            cursor.execute("""
                INSERT INTO QLBanQuanAo.GioHang
                (MaKH, MaSP, SoLuong, MauSacDaChon, KichCoDaChon)
                VALUES (%s, %s, %s, %s, %s)
            """, (ma_kh, new_sp, so_luong, new_mau, new_size))

        conn.commit()
        cursor.close()
        conn.close()

        return jsonify({'success': True})

    except Exception as e:
        print("Error updating cart item:", e)
        return jsonify({'error': 'server_error'}), 500

