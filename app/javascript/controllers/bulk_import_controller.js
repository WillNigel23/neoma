import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="bulk-import"
export default class extends Controller {

  connect() {
    const fileInput = this.element.querySelector("#import_file");
    const uploadButton = this.element.querySelector("#upload_button");

    uploadButton.addEventListener("click", () => fileInput.click());

    fileInput.addEventListener("change", () => {
      if (fileInput.files.length > 0) {
        this.element.submit();
      }
    });
  }

}
