import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="hello2"
export default class extends Controller {
  connect() {
    this.element.textContent = "2339q2232323222222222229!"

    console.log("0");
  }
}
