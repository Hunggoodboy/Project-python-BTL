const track = document.querySelector('.track');
const slides = Array.from(track.children);
const nextBtn = document.querySelector('.arrowR');
const prevBtn = document.querySelector('.arrowL');
let currentIndex = 0;

// Function to move to a slide
function goToSlide(index) {
    // Wrap around for infinite loop
    if (index < 0) {
        currentIndex = slides.length - 1;
    } else if (index >= slides.length) {
        currentIndex = 0;
    } else {
        currentIndex = index;
    }
    track.style.transform = `translateX(-${currentIndex * 100}%)`;
    track.style.transition = 'transform 0.5s ease';
}

// Arrow click handlers
nextBtn.addEventListener('click', () => goToSlide(currentIndex + 1));
prevBtn.addEventListener('click', () => goToSlide(currentIndex - 1));

// Auto slide
setInterval(() => goToSlide(currentIndex + 1), 3000); // slide every 3s
