import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="lazy"
export default class extends Controller {
  connect() {
    setTimeout(()=> {
      const imgs = document.querySelectorAll('img');
      imgs.forEach(img => {
        function loaded() {
          img.classList.add('in');
        }

        if (img.complete) {
          loaded();
        }
        else {
          img.addEventListener('load', loaded)
        }
      });
    }, 50);
  }
}
