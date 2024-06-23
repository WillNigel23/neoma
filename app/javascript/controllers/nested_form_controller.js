import NestedForm from '@stimulus-components/rails-nested-form'

export default class extends NestedForm {

  static values = {
    wrapperSelectorValue: String
  }

  connect() {
    super.connect()
  }

  remove(e) {
    e.preventDefault();

    const wrapper = e.target.closest(this.wrapperSelectorValue)

    if (wrapper.dataset.newRecord === 'true') {
      wrapper.remove()
    } else {
      wrapper.style.display = 'none'

      const input = wrapper.querySelector("input[name*='_destroy']")
      input.value = wrapper.dataset.newRecord
    }

    const event = new CustomEvent('rails-nested-form:remove', { bubbles: true })
    this.element.dispatchEvent(event)
  }
}
