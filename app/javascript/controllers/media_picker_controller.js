import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="media-picker"
export default class extends Controller {
  static targets = ['form', 'imageField', 'hiddenField', 'imageUploadForm']

  select(event) {
    const imageId = event.currentTarget.dataset.imageId;

    const hiddenInput = this.formTarget.querySelector('input[name="image_id"]');

    if (hiddenInput) {
      hiddenInput.value = imageId;
    }
  }

  imageUploadFormTargetConnected(target) {
    const imageUploadInput = target.querySelector("#image_upload_files");
    const uploadButton = target.querySelector("#upload_image_button");

    uploadButton.addEventListener("click", () => imageUploadInput.click());

    imageUploadInput.addEventListener("change", () => {
      if (imageUploadInput.files.length > 0) {
        target.requestSubmit();
      }
    });
  }

  delete(event) {
    this.hiddenFieldTarget.value = '';
    event.currentTarget.remove();
    this.imageFieldTarget.remove();
  }
}
