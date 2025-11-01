document.addEventListener("DOMContentLoaded", () => {

    // Chọn màu
    const colorButtons = document.querySelectorAll(".options button, .color-options img");
   
    colorButtons.forEach(btn => {
        btn.addEventListener("click", () => {
            colorButtons.forEach(b => b.classList.remove("active"));
            btn.classList.add("active");
            if(btn.tagName === "IMG"){
                btn.classList.add("active");
            }
        });
    });

    // Nút đặt hàng
    const buyNowBtn = document.getElementById("modal-buy-now");
    if(buyNowBtn){
        buyNowBtn.addEventListener("click", () => {
            console.log("📦 Click Đặt hàng");
            const quantity = document.getElementById("quantity").value;
            const selectedColorBtn = document.querySelector(".options button.active, .color-options img.active");
            console.log("Số lượng:", quantity);
            console.log("PRODUCT_ID:", PRODUCT_ID);
            let color = "";
            if(selectedColorBtn){
                if(selectedColorBtn.tagName === "BUTTON"){
                    color = selectedColorBtn.querySelector("span") ? selectedColorBtn.querySelector("span").innerText : "";
                } else if(selectedColorBtn.tagName === "IMG"){
                    color = selectedColorBtn.alt || "";
                }
            }

            const formData = new FormData();
            formData.append("product_id", PRODUCT_ID); // PRODUCT_ID lấy từ template
            formData.append("quantity", quantity);
            formData.append("color", color);
            
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
