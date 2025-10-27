document.addEventListener("DOMContentLoaded", function() {
    const cartIcon = document.querySelector(".cart-icon");
    const dropdown = document.querySelector(".cart-dropdown");
    if (!cartIcon || !dropdown) return;
    cartIcon.addEventListener("click", function(e) {
        e.stopPropagation();
        dropdown.classList.toggle("hidden");
    });
    document.addEventListener("click", function() {
        dropdown.classList.add("hidden");
    });
});
