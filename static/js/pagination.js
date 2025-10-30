document.addEventListener("DOMContentLoaded", function () {
    const productsPerPage = 5;
    const container = document.getElementById("product-table");
    const paginationDiv = document.getElementById("pagination");

    // Lưu bản sao các ô sản phẩm
    const items = [...container.querySelectorAll("td")].filter(td => td.innerHTML.trim() !== "");
    const totalPages = Math.ceil(items.length / productsPerPage);
    let currentPage = 1;

    function renderPage(page) {
        currentPage = page;

        const start = (page - 1) * productsPerPage;
        const end = start + productsPerPage;
        const slice = items.slice(start, end);

        // Xóa nội dung cũ
        container.innerHTML = "";

        // Tạo lại hàng chứa sản phẩm
        let tr = document.createElement("tr");
        slice.forEach((el, idx) => {
            tr.appendChild(el.cloneNode(true)); // clone để giữ dữ liệu
            // chia 5 sản phẩm 1 hàng
            if ((idx + 1) % 5 === 0 || idx === slice.length - 1) {
                container.appendChild(tr);
                tr = document.createElement("tr");
            }
        });

        renderPagination();
    }

    function renderPagination() {
        paginationDiv.innerHTML = "";
        for (let i = 1; i <= totalPages; i++) {
            const btn = document.createElement("button");
            btn.textContent = i;
            if (i === currentPage) btn.classList.add("active");
            btn.onclick = () => renderPage(i);
            paginationDiv.appendChild(btn);
        }
    }

    renderPage(currentPage);
});