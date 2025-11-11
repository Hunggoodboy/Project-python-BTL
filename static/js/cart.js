
//Script xóa sản phẩm
document.querySelectorAll('.remove-btn').forEach(btn => {
    btn.addEventListener('click', async () => {
        console.log(btn.dataset.MaSP, btn.dataset.color, btn.dataset.size)
        await fetch('/remove-from-cart', {
            method: "POST",
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify({
                maSP: btn.dataset.product_id,
                mau: btn.dataset.color,
                size: btn.dataset.size
            })
        })
        location.reload();
    })
})


// Script cho checkbox và order hàng
document.addEventListener('DOMContentLoaded', () => {
    const checkboxes = document.querySelectorAll('.cart-checkbox');
    const totalPriceEl = document.getElementById("total-price");
    const selectedCountEl = document.getElementById("selected-count");
    const createOrderBtn = document.getElementById("create-order-btn");

    // restore trạng thái từ localStorage
    const savedChecked = JSON.parse(localStorage.getItem('cartChecked') || '{}');
    checkboxes.forEach(cb => {
    const key = `${cb.dataset.id}_${cb.dataset.color}_${cb.dataset.size}`;
    if(savedChecked[key]) cb.checked = true;
});

    function updateSummary() {
        const checkboxes = document.querySelectorAll(".cart-checkbox"); // lấy lại từ DOM
        let total = 0;
        let count = 0;

        checkboxes.forEach(cb => {
            if(cb.checked){
                const price = parseFloat(cb.dataset.price) || 0;
                const quantity = parseInt(cb.dataset.quantity) || 1;
                total += price * quantity;
                count++;
            }
        });

        totalPriceEl.textContent = total.toLocaleString("vi-VN") + "₫";
        selectedCountEl.textContent = count;
    }

    function saveChecked() {
        const obj = {};
        checkboxes.forEach(cb => {
            const key = `${cb.dataset.id}_${cb.dataset.color}_${cb.dataset.size}`;
            obj[key] = cb.checked;
        });
        localStorage.setItem('cartChecked', JSON.stringify(obj));
    }

    // các event
    checkboxes.forEach(cb => {
        cb.addEventListener("change", () => {
        saveChecked();
        updateSummary();
        });
    });

    createOrderBtn.addEventListener("click", async() => {
        const selected = Array.from(checkboxes)
            .filter(cb => cb.checked)
            .map(cb => ({
                product_id: cb.dataset.id,
                quantity: cb.dataset.quantity || 1,
                color: cb.dataset.color || '',
                size: cb.dataset.size || ''
            }));

        if (selected.length === 0) {
            alert("Vui lòng chọn ít nhất 1 sản phẩm để đặt hàng!");
            return;
        }

        // Dùng FormData
        const promises = selected.map(item => {
            const formData = new FormData();
            formData.append("product_id", item.product_id);
            formData.append("quantity", item.quantity);
            formData.append("color", item.color);
            formData.append("size", item.size);

            return fetch("/create_order", { method: "POST", body: formData })
                .then(res => res.json())
                .then(data => {
                    if (data.success) {
                        console.log("Tạo đơn thành công cho", item.product_id);
                        return fetch("/remove-from-cart", {
                            method: "POST",
                            headers: {'Content-Type':'application/json'},
                            body: JSON.stringify({
                                maSP: item.product_id,
                                mau: item.color,
                                size: item.size
                            })
                        });
                    }
                });
        });

        Promise.all(promises).then(() => {
            window.location.href = "/orders";
        });

    });

    // tính summary ngay khi load
    updateSummary();
});