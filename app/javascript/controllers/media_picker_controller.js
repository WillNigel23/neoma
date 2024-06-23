import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="media-picker"
export default class extends Controller {
  static targets = ['form', 'imageField', 'hiddenField']

  select(event) {
    const imageId = event.currentTarget.dataset.imageId;

    const hiddenInput = this.formTarget.querySelector('input[name="image_id"]');

    if (hiddenInput) {
      hiddenInput.value = imageId;
    }
  }

  delete(event) {
    this.hiddenFieldTarget.value = '';
    event.currentTarget.remove();
    this.imageFieldTarget.remove();
  }
}
