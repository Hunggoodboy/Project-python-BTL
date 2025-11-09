
function openEditForm(p) {
    const popup = document.getElementById("popupEdit");
    const form = popup.querySelector(".product-form");

    popup.classList.remove("hidden");

    form.action = `/product/edit/${p.MaSP}`;
    // Xóa form cũ trước khi tạo lại (tránh chồng input)
    form.innerHTML = "";

    // Danh sách trường + label hiển thị
    const mapping = {
        MaDM: "Mã danh mục",
        TenSP: "Tên sản phẩm",
        MoTa: "Mô tả",
        Gia: "Giá",
        MauSac: "Màu sắc",
        Size: "Lựa chọn kích thước",
        ChatLieu: "Chất liệu",
        SoLuongcon: "Số lượng còn",
        HinhAnh: "Hình ảnh",
        Season: "Season"
    };

    Object.keys(mapping).forEach(key => {
        const wrapper = document.createElement("div");
        wrapper.classList.add("input-wrapper"); // cho dễ style

        const label = document.createElement("label");
        label.textContent = mapping[key] + ": "; // thêm dấu :

        const input = document.createElement("input");
        input.name = key;
        input.type = "text";
        input.value = p[key] ?? "";
        input.placeholder = p[key] ?? "";

        label.appendChild(input);
        wrapper.appendChild(label);
        form.appendChild(wrapper);
    });

    const btnDiv = document.createElement("div");
    btnDiv.classList.add("optionDiv");
    const deleteBtn = document.createElement("button");
    deleteBtn.classList.add("delete");
    deleteBtn.type = "button";
    deleteBtn.textContent = "Xóa sản phẩm";

    const cancelBtn = document.createElement("button");
    cancelBtn.classList.add("cancel");
    cancelBtn.type = "reset";
    cancelBtn.textContent = "Hủy";

    const saveBtn = document.createElement("button");
    saveBtn.classList.add("save");
    saveBtn.type = "submit";
    saveBtn.textContent = "Lưu";

    btnDiv.appendChild(deleteBtn);
    btnDiv.appendChild(cancelBtn);
    btnDiv.appendChild(saveBtn);
    form.appendChild(btnDiv);
}

const closeBtn = document.getElementById("close-popup");
closeBtn.addEventListener("click", () => closeEditForm());

function closeEditForm() {
    const popup = document.getElementById("popupEdit");
    const form = popup.querySelector(".product-form");
    popup.classList.add("hidden");
}

function openAddForm() {
    const popup = document.getElementById("popupAdd");
    const form = popup.querySelector(".product-form");
    popup.classList.remove("hidden");
    form.innerHTML = "";
    const mapping = {
        MaSP: "Mã sản phẩm",
        MaDM: "Mã danh mục",
        TenSP: "Tên sản phẩm",
        MoTa: "Mô tả",
        Gia: "Giá",
        MauSac: "Màu sắc",
        ChatLieu: "Chất liệu",
        SoLuongcon: "Số lượng còn",
        HinhAnh: "Hình ảnh",
        Season: "Season"
    };
    Object.keys(mapping).forEach(key => {
        const wrapper = document.createElement("div");
        wrapper.classList.add("input-wrapper");
        const label = document.createElement("label");
        label.textContent = mapping[key] + ": ";
        const input = document.createElement("input");
        input.name = key;
        input.type = "text";
    })
}
