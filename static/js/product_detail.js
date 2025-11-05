let currentImage = 0;
const images = JSON.parse(document.getElementById('image-data').textContent || '[]');

window.addEventListener('DOMContentLoaded', () => {
    const data = document.getElementById('image-data').textContent || '[]';
    const images = JSON.parse(data);
    window.images = images;
    window.currentImage = 0;
    if (images.length > 0) {
        document.getElementById('main-image').src = images[0];
    }
});

function prevImage() {
    if(images.length < 2) return;
    currentImage = (currentImage - 1 + images.length) % images.length;
    document.getElementById('main-image').src = images[currentImage];
}

function nextImage() {
    if(images.length < 2) return;
    currentImage = (currentImage + 1) % images.length;
    document.getElementById('main-image').src = images[currentImage];
}

function changeColor(imageUrl) {
    document.getElementById('main-image').src = imageUrl;
    currentImage = images.indexOf(imageUrl);
}

function openModal(id) {
    document.getElementById(id).style.display = 'block';
}
function closeModal(id) {
    document.getElementById(id).style.display = 'none';
}

function openProductModal(type) {
    const modal = document.getElementById('product-modal');
    modal.style.display = 'block';
    const addBtn = document.getElementById('modal-add-cart');
    const buyBtn = document.getElementById('modal-buy-now');
    if(type === 'add') {
        addBtn.style.display = 'block';
        buyBtn.style.display = 'none';
    } else if(type === 'buy') {
        addBtn.style.display = 'none';
        buyBtn.style.display = 'block';
    }
}

function closeProductModal() {
    document.getElementById('product-modal').style.display = 'none';
}

function changeModalImage(imgUrl) {
    document.getElementById('modal-main-img').src = imgUrl;
}

function changeQuantity(delta) {
    let input = document.getElementById('quantity');
    let value = parseInt(input.value);
    value += delta;
    if(value < 1) value = 1;
    if(value > maxStock) value = maxStock;
    input.value = value;
    document.getElementById('decrease').disabled = (value === 1);
    document.getElementById('increase').disabled = (value === maxStock);
}

window.onload = function() {
    changeQuantity(0);
}
