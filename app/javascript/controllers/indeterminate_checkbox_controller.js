import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="indeterminate-checkbox"
export default class extends Controller {
  connect() {
    this.element.indeterminate = true;
  }
}
