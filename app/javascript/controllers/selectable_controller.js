import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="selectable"
export default class extends Controller {
  static targets = ['item']

  static values = {
    selectedClasses: {
      type: String,
      default: 'border-spina'
    },
    deselectedClasses: {
      type: String,
      default: 'border-transparent'
    }
  }

  select(event) {
    let item = event.currentTarget;

    this.itemTargets.forEach(function(item) {
      this.deactivate(item)
    }.bind(this))

    this.activate(item)
  }

  activate(item) {
    this.toggleClasses(item, true)
  }

  deactivate(item) {
    this.toggleClasses(item, false)
  }

  toggleClasses(item, force) {
    item.classList.toggle(this.selectedClassesValue, force);
    item.classList.toggle(this.deselectedClassesValue, !force);
  }
}
