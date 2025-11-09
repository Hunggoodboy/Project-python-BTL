document.addEventListener("DOMContentLoaded", () => {

    const productBtn = document.querySelector(".product-btn");
    const userBtn = document.querySelector(".user-btn");
    const productTab = document.querySelector(".product-tab");
    const userTab = document.querySelector(".user-tab");

    // Tab switch
    productBtn.addEventListener("click", () => switchTab('product'));
    userBtn.addEventListener("click", () => switchTab('user'));

    function switchTab(tabType) {
        if(tabType === 'product'){
            productBtn.classList.add("active");
            userBtn.classList.remove("active");
            productTab.style.display = "block";
            userTab.style.display = "none";
        } else {
            userBtn.classList.add("active");
            productBtn.classList.remove("active");
            userTab.style.display = "block";
            productTab.style.display = "none";
        }
        renderPagination(tabType);
    }

    // Render pagination
    function renderPagination(tabType){
        const table = document.querySelector(tabType === 'product' ? "#product-table tbody" : "#user-table tbody");
        const template = document.querySelector(`#${tabType}-template`);
        const pageDiv = document.getElementById("pagination");
        const items = tabType === 'product' ? window.productsData : window.usersData;
        const itemsPerPage = 10;
        const totalPages = Math.ceil(items.length / itemsPerPage);
        let currentPage = 1;

        function renderPage(page){
            if(page < 1 || page > totalPages) return;
            currentPage = page;
            table.innerHTML = "";
            const start = (page - 1) * itemsPerPage;
            const end = start + itemsPerPage;
            const slice = items.slice(start, end);

            if(tabType === 'product')
                if (page === 1) {
                    // Hàng đầu: dấu (+) và 4 sp
                    let tr = document.createElement("tr");
                    const addCell = document.createElement("td");
                    const addBtn = document.createElement("button");
                    addBtn.textContent = "+";
                    addCell.className = "add-cell";
                    addBtn.className = "addBtn";
                    addBtn.onclick = () => alert("Thêm sản phẩm");
                    addCell.appendChild(addBtn);
                    tr.appendChild(addCell);
                    for (let i = 0; i < 4 && i < slice.length; i++) tr.appendChild(createProductTD(slice[i]));
                    table.appendChild(tr);

                    tr = document.createElement("tr");
                    for (let i = 4; i < 9 && i < slice.length; i++) tr.appendChild(createProductTD(slice[i]));
                    table.appendChild(tr);
                } else {
                    let tr = document.createElement("tr");
                    slice.forEach((item, idx) => {
                        tr.appendChild(createProductTD(item));
                        if ((idx + 1) % 5 === 0 || idx === slice.length - 1) {
                            table.appendChild(tr);
                            tr = document.createElement("tr");
                        }
                    });
                }
            else{
                slice.forEach(u => {
                    table.appendChild(createUserTR(u));
                })
            }

            // Pagination buttons
            pageDiv.innerHTML="";
            const prev=document.createElement("button");
            prev.textContent="«";
            prev.disabled=currentPage===1;
            prev.onclick=()=>renderPage(currentPage-1);
            pageDiv.appendChild(prev);

            for(let i=1;i<=totalPages;i++){
                const btn=document.createElement("button");
                btn.textContent=i;
                if(i===currentPage) btn.classList.add("active");
                btn.onclick=()=>renderPage(i);
                pageDiv.appendChild(btn);
            }

            const next=document.createElement("button");
            next.textContent="»";
            next.disabled=currentPage===totalPages;
            next.onclick=()=>renderPage(currentPage+1);
            pageDiv.appendChild(next);
        }

        function createProductTD(p){
            const td=template.content.firstElementChild.cloneNode(true);
            const div=td.querySelector("div.product");

            td.querySelector("img.main").src=`/static/${p.HinhAnh}`;
            td.querySelector(".name").textContent=p.TenSP;
            td.querySelector(".price").textContent=`${p.Gia}₫`;
            td.querySelector(".material").textContent=p.ChatLieu;
            td.querySelector(".discount").textContent=p.Discount?`-${p.Discount}%`:"";
            td.querySelector(".overlay").onclick=() => openEditForm(p);
            return td;
        }

        function createUserTR(u) {
            const tr = document.querySelector("#user-template").content.firstElementChild.cloneNode(true);
            tr.querySelector(".stt").textContent=u.MaKH;
            tr.querySelector(".name").textContent = u.HoTen;
            tr.querySelector(".username").textContent = u.UserName;
            tr.querySelector(".sdt").textContent = u.SDT;
            tr.querySelector(".address").textContent = u.Address;
            return tr;
        }

        function openEditForm(p) {
            const popup = document.getElementById("popup");
            const form = popup.querySelector(".product-form"); // 👈 dòng cần thêm

            popup.classList.remove("hidden");


            const mapping = ["MaDM", "TenSP", "MoTa", "Gia", "MauSac", "ChatLieu", "SoLuongCon", "HinhAnh", "Season"];

            mapping.forEach(key => {
                const input = form.querySelector(`[name='${key}']`);
                if (input) {
                    input.value = p[key] ?? "";
                    input.placeholder = p[key] ?? "";
                }
            });
        }
        const closeBtn = document.getElementById("close-popup");
        closeBtn.addEventListener("click", () => closeEditForm());
        function closeEditForm() {
            const popup = document.getElementById("popup");
            const form = popup.querySelector(".product-form");
            popup.classList.add("hidden");
        }

        renderPage(1);
    }

    // Khởi tạo trang đầu tiên
    switchTab('product');

});
