document.addEventListener("DOMContentLoaded", () => {

    // Chọn màu
    const colorButtons = document.querySelectorAll(".color-options button");
    colorButtons.forEach(btn => {
        btn.addEventListener("click", () => {
            colorButtons.forEach(b => b.classList.remove("active"));
            btn.classList.add("active");
        });
    });
    // Chọn size
    const sizeButtons = document.querySelectorAll(".size-options button");
    sizeButtons.forEach(btn => {
        btn.addEventListener("click", () => {
            sizeButtons.forEach(b => b.classList.remove("active"));
            btn.classList.add("active");
        });
    });

    // Nút đặt hàng
    const buyNowBtn = document.getElementById("modal-buy-now");
    if(buyNowBtn){
        buyNowBtn.addEventListener("click", () => {
            const quantity = document.getElementById("quantity").value;
            const selectedColorBtn = document.querySelector(".color-options button.active");
            const selectedSizeBtn = document.querySelector(".size-options button.active");
            const color = selectedColorBtn.textContent.trim();
            const size = selectedSizeBtn.textContent.trim();

            const formData = new FormData();
            formData.append("product_id", PRODUCT_ID); // PRODUCT_ID lấy từ template
            formData.append("quantity", quantity);
            formData.append("color", color);
            formData.append("size", size);
            //gửi lại lên routes orders
            fetch("/create_order", {
                method: "POST",
                body: formData
            })
            .then(res => res.json())
            .then(data => {
                if(data.success){
                    alert("Đặt hàng thành công!");
                    window.location.href = "/orders"; // Về trang đơn hàng
                } else {
                    alert("Lỗi: " + data.message);
                }
            })
            .catch(err => console.error(err));
        });
    }

});
