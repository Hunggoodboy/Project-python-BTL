let currentImage = 0;
const images = JSON.parse(document.getElementById('image-data').textContent || '[]');

function prevImage() {
  const main = document.getElementById('main-image');
  currentImage = (currentImage - 1 + images.length) % images.length;
  main.src = images[currentImage];
}

function nextImage() {
  const main = document.getElementById('main-image');
  currentImage = (currentImage + 1) % images.length;
  main.src = images[currentImage];
}

function changeColor(imageUrl) {
  document.getElementById('main-image').src = imageUrl;
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
