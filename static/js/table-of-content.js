document.addEventListener("DOMContentLoaded", () => {
    const left = document.querySelector(".left");
    const right = document.querySelector(".right");

    // Lấy tất cả phần tiêu đề có id (các div.s1, div.s2)
    const allHeadings = left.querySelectorAll(".s1, .s2");

    // Tạo khung TOC
    const toc = document.createElement("div");
    toc.classList.add("toc");

    const title = document.createElement("h2");
    title.classList.add("toc-title");
    title.textContent = "Các mục trong trang";
    toc.appendChild(title);

    const container = document.createElement("div");
    container.classList.add("toc-container");

    const ulMain = document.createElement("ul");
    ulMain.classList.add("a");

    let currentLi = null;   // lưu <li> hiện tại cho nhóm con

    allHeadings.forEach(h => {
        const a = document.createElement("a");
        a.href = `#${h.id}`;
        a.textContent = h.textContent.trim();

        // Nếu là s1 => tiêu đề chính
        if (h.classList.contains("s1")) {
            const li = document.createElement("li");
            a.classList.add("head1");
            li.appendChild(a);
            ulMain.appendChild(li);

            // tạo danh sách con <ul> b cho tiêu đề chính này
            const ulSub = document.createElement("ul");
            ulSub.classList.add("b");
            li.appendChild(ulSub);

            currentLi = li; // cập nhật nhóm hiện tại
        }

        // Nếu là s2 => mục con của s1 gần nhất
        else if (h.classList.contains("s2") && currentLi) {
            const liSub = document.createElement("li");
            a.classList.add("head2");
            liSub.appendChild(a);
            currentLi.querySelector(".b").appendChild(liSub);
        }
    });

    container.appendChild(ulMain);
    toc.appendChild(container);

    // Gắn TOC vào cột bên phải
    right.appendChild(toc);
});
