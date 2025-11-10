// script đổi số lượng sản phẩm
const debounceTimeouts = {};

document.querySelectorAll('.btnL, .btnR').forEach(btn => {
    btn.addEventListener('click', () => {
        // Lấy delta từ class
        const delta = btn.classList.contains('btnL') ? -1 : 1;

        // Lấy thông tin từ ID của button
        const parts = btn.id.split('_');
        // btn.id = "decrease_MaSP_Mau_Size" hoặc "increase_MaSP_Mau_Size"
        const MaSP = parts[1];
        const mau = parts[2];
        const size = parts[3];

        const quantityInput = document.getElementById(`quantity_${MaSP}_${mau}_${size}`);
        const maxStock = parseInt(document.getElementById(`left_${MaSP}_${mau}_${size}`).value);

        let value = parseInt(quantityInput.value);
        value += delta;
        if (value < 1) value = 1;
        if (value > maxStock) value = maxStock;
        quantityInput.value = value;

        document.getElementById(`decrease_${MaSP}_${mau}_${size}`).disabled = (value === 1);
        document.getElementById(`increase_${MaSP}_${mau}_${size}`).disabled = (value === maxStock);

        // Debounce riêng cho từng sản phẩm
        const key = `${MaSP}_${mau}_${size}`;
        clearTimeout(debounceTimeouts[key]);
        debounceTimeouts[key] = setTimeout(() => {
            updateCart(MaSP, mau, size, value);
        }, 500);
    });
});

function updateCart(MaSP, mau, size, quantity) {
    fetch('/update-cart', {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({MaSP: MaSP, MauSacDaChon: mau, KichCoDaChon: size, SoLuong: quantity})
    })
        .then(res => res.json())
        .then(data => {
            if(data.success) {
                location.reload();
            }
        })
        .catch(err => console.error(err));
}


// script đổi màu và size
document.querySelectorAll('.optionBtn').forEach(btn => {
    btn.addEventListener('click', () => {
        const targetId = btn.dataset.target;
        const dropdown = document.getElementById(targetId);
        //tắt hết dropdown khác
        document.querySelectorAll('.dropdown.active').forEach(dd => {
            if (dd !== dropdown) dd.classList.remove('active');
        });
        dropdown.classList.toggle('active');
    });
});

// Gửi yêu cầu đổi màu/size sản phẩm trong giỏ
async function updateCartOption(maSP, oldMau, oldSize) {
    const form = document.getElementById(`form_${maSP}_${oldMau}_${oldSize}`);
    const newMau = form.querySelector('input[name="color"]:checked')?.value || oldMau;
    const newSize = form.querySelector('input[name="size"]:checked')?.value || oldSize;

    // Nếu không chọn gì mới → bỏ qua
    if (newMau === oldMau && newSize === oldSize) {
        alert("Bạn chưa thay đổi màu hoặc size!");
        return;
    }

    const so_luong = document.getElementById(`quantity_${maSP}_${oldMau}_${oldSize}`).value || 1;

    try {
        const res = await fetch("/update-cart-item-option", {
            method: "POST",
            headers: {"Content-Type": "application/json"},
            body: JSON.stringify({
                old_ma_sp: maSP,
                new_ma_sp: maSP,
                old_mau: oldMau,
                old_size: oldSize,
                new_mau: newMau,
                new_size: newSize,
                so_luong
            })
        });

        const data = await res.json();
        if (data.success) {
            alert("Cập nhật giỏ hàng thành công!");
            location.reload();
        } else if (data.error === "not_logged_in") {
            alert("Vui lòng đăng nhập trước khi thao tác!");
            window.location.href = "/login";
        } else alert("Lỗi khi cập nhật sản phẩm!");

    } catch (err) {
        console.error(err);
        alert("Không thể kết nối server!");
    }
}
