import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ['body']

  close() {
    document.addEventListener("turbo:before-fetch-request", async (event) => {
      event.preventDefault()
      this.bodyTargets.forEach(body => {
        body.classList.remove('in');
      });

      setTimeout(() => {
        event.detail.resume()
      }, 500);
    });
  }

  closeV2(event) {
    event.preventDefault();

    var turboFrameTag = document.createElement("turbo-frame");
    turboFrameTag.id = 'modal'

    this.bodyTargets.forEach(body => {
      body.classList.remove('in');
    });

    setTimeout(() => {
      document.getElementById('modal').replaceWith(turboFrameTag);
    }, 500);
  }
}
