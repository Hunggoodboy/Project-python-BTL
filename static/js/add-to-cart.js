document.addEventListener('DOMContentLoaded', () => {

    function changeQuantity1(delta) {
        let input = document.getElementById('quantity1');
        let value = parseInt(input.value);
        value += delta;
        if(value < 1) value = 1;
        if(value > maxStock) value = maxStock;
        input.value = value;
        document.getElementById('decrease1').disabled = (value === 1);
        document.getElementById('increase1').disabled = (value === maxStock);
    }
    // --- chọn size ---
    function selectSize(sizeBtn) {
        // xóa active cũ
        document.querySelectorAll('.size-btn').forEach(btn => btn.classList.remove('active'));
        // gán active mới
        sizeBtn.classList.add('active');
        // lưu lại giá trị
        document.getElementById("selected-size").value = sizeBtn.innerText.trim();
    }

    // --- chọn màu ---
    function selectColor(colorBtn) {
        document.querySelectorAll('.color-thumb').forEach(btn => btn.classList.remove('active'));
        colorBtn.classList.add('active');
        document.getElementById("selected-color").value = colorBtn.innerText.trim();
    }

    // --- thêm vào giỏ (fetch) ---
    async function addToCart() {
        const ma_sp = document.getElementById("product-id").value;
        const so_luong = document.getElementById("quantity1").value || 0;
        const mau = document.getElementById("selected-color").value || "Không chọn";
        const size = document.getElementById("selected-size").value || "Không chọn";

        try {
            const res = await fetch("/add-no-reload", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ ma_sp, so_luong, mau, size })
            });

            const data = await res.json();
            if (data.success) {
                alert("Đã thêm vào giỏ hàng!");
            } else if (data.error === "not_logged_in") {
                alert("Vui lòng đăng nhập trước khi mua hàng!");
                window.location.href = "/login";
            } else {
                alert("Lỗi khi thêm sản phẩm!");
            }
        } catch (err) {
            console.error(err);
            alert("Lỗi kết nối đến server!");
        }
    }

    // gán hàm vào window để gọi được từ HTML
    window.changeQuantity1 = changeQuantity1;
    window.selectSize = selectSize;
    window.selectColor = selectColor;
    window.addToCart = addToCart;

});