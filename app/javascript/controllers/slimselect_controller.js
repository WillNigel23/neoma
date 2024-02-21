import { Controller } from "@hotwired/stimulus"
import SlimSelect from 'slim-select';

// Connects to data-controller="slimselect"
export default class extends Controller {
  static targets = ["field"]
  connect() {
      console.log("Hello");
      new SlimSelect({
          select: this.fieldTarget
      })
  }
}
