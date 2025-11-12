function buildForm(form, mapping, data = {}, extraButtons = []) {
    form.innerHTML = "";

    // Tạo các input theo mapping
    Object.entries(mapping).forEach(([key, labelText]) => {
        const wrapper = document.createElement("div");
        wrapper.classList.add("input-wrapper");

        const label = document.createElement("label");
        label.textContent = `${labelText}: `;

        const input = document.createElement("input");
        input.name = key;
        input.type = "text";
        input.value = data[key] ?? "";
        input.placeholder = data[key] ?? "";

        label.appendChild(input);
        wrapper.appendChild(label);
        form.appendChild(wrapper);
    });

    // Thêm nhóm nút
    const btnDiv = document.createElement("div");
    btnDiv.classList.add("optionDiv");

    // Các nút bổ sung riêng
    extraButtons.forEach(btn => btnDiv.appendChild(btn));

    // Cancel & Save (chung)
    const cancelBtn = document.createElement("button");
    cancelBtn.classList.add("cancel");
    cancelBtn.type = "reset";
    cancelBtn.textContent = "Hủy";

    const saveBtn = document.createElement("button");
    saveBtn.classList.add("save");
    saveBtn.type = "submit";
    saveBtn.textContent = "Lưu";

    btnDiv.appendChild(cancelBtn);
    btnDiv.appendChild(saveBtn);
    form.appendChild(btnDiv);
}

function openEditForm(p) {
    const popup = document.getElementById("popupEdit");
    const form = popup.querySelector(".product-form");
    popup.classList.remove("hidden");

    form.action = `/product/edit/${p.MaSP}`;
    form.method = "POST";

    const mapping = {
        MaDM: "Mã danh mục",
        TenSP: "Tên sản phẩm",
        MoTa: "Mô tả",
        Gia: "Giá",
        MauSac: "Màu sắc",
        Size: "Kích thước",
        ChatLieu: "Chất liệu",
        SoLuongcon: "Số lượng còn",
        HinhAnh: "Hình ảnh",
        Season: "Season"
    };

    const deleteBtn = document.createElement("button");
    deleteBtn.classList.add("delete");
    deleteBtn.type = "button";
    deleteBtn.textContent = "Xóa sản phẩm";
    deleteBtn.addEventListener("click", async () => {
        if (confirm("Bạn có chắc muốn xóa sản phẩm này?")) {
            try {
                const res = await fetch(`/product/delete/${p.MaSP}`, { method: "POST" });
                if (res.ok) {
                    alert("Xóa thành công!");
                    location.reload();
                } else alert("Xóa thất bại!");
            } catch (err) {
                alert("Có lỗi xảy ra khi xóa!");
            }
        }
    });

    buildForm(form, mapping, p, [deleteBtn]);
}

function openAddForm() {
    const popup = document.getElementById("popupAdd");
    const form = popup.querySelector(".product-form");
    popup.classList.remove("hidden");

    form.action = "/product/add";
    form.method = "POST";

    const mapping = {
        MaSP: "Mã sản phẩm",
        MaDM: "Mã danh mục",
        TenSP: "Tên sản phẩm",
        MoTa: "Mô tả",
        Gia: "Giá",
        MauSac: "Màu sắc",
        Size: "Kích thước",
        ChatLieu: "Chất liệu",
        SoLuongcon: "Số lượng còn",
        HinhAnh: "Hình ảnh",
        Season: "Season"
    };

    buildForm(form, mapping);
}

function openEditUserForm(u) {
    const popup = document.getElementById("popupEditUser");
    const form = popup.querySelector(".user-form");
    popup.classList.remove("hidden");

    form.action = `/user/edit/${u.MaKH}`;
    form.method = "POST";

    const mapping = {
        HoTen: "Họ và tên",
        UserName: "Username",
        MatKhau: "Mật khẩu",
        SDT: "Số điện thoại",
        Address: "Địa chỉ",
        Role: "Vai trò"
    };

    buildForm(form, mapping, u);
}

const closeBtn = document.getElementById("close-popup");
closeBtn.addEventListener("click", () => closeForm("popupEdit"));

const closeBtn2 = document.getElementById("close-popup2");
closeBtn2.addEventListener("click", () => closeForm("popupAdd"));

const closeBtn3 = document.getElementById("close-popup3");
closeBtn3.addEventListener("click", () => closeForm("popupEditUser"));

function closeForm(popupName) {
    document.getElementById(popupName).classList.add("hidden");
}

function deleteUser(maKH) {
    if (confirm("Bạn có chắc muốn xoá?")) {
        fetch(`/user/delete/${maKH}`, { method: "POST" })
            .then(() => location.reload());
    }
}
