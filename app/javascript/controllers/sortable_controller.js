import Sortable from '@stimulus-components/sortable'

export default class extends Sortable {
  connect() {
    super.connect()
  }

  onUpdate(event) {
    super.onUpdate(event);

    Array.from(this.element.children).forEach((item, index) => {
      const positionInput = item.querySelector(`[name*="[position]"]`)
      if (positionInput) {
        positionInput.value = index + 1;
      }
    })
  }
}
