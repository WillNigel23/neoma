import { Controller } from "@hotwired/stimulus"
import SlimSelect from 'slim-select'

// Connects to data-controller="slimselect"
export default class extends Controller {
  static values = {
    allowDeselect: { type: Boolean, default: true },
    closeOnSelect: { type: Boolean, default: true },
    hideSelected: { type: Boolean, default: true },
    maxValuesShown: { type: Number, default: 100 },
    selectAll: { type: Boolean, default: false }
  }

  connect() {
    this.slimselect = new SlimSelect({
      select: this.element,
      settings: {
        allowDeselect: this.allowDeselectValue,
        closeOnSelect: this.closeOnSelectValue,
        maxValuesShown: this.maxValuesShownValue,
        selectAll: this.selectAllValue
      }
    })
  }
}
