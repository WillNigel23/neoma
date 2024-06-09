import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form"
export default class extends Controller {

  static values = {
    formId: String
  }

  connect() {
    this.boundSubmit = this.submit.bind(this);

    this.element.addEventListener('click', this.boundSubmit);
  }

  submit(event) {
    event.preventDefault();

    document.getElementById(this.formIdValue).submit();
  }
}
