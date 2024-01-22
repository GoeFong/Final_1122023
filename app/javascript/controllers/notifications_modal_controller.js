import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notifications-modal"
export default class extends Controller {
  static targets = ["notification"];

  connect() {
    this.flag = false;
  }

  toggleNotification() {
    if (!this.flag) {
      this.showNotification();
    } else {
      this.hideNotification();
    }
  }

  showNotification() {
    this.notificationTarget.classList.add("translate-x-full");
    this.notificationTarget.classList.remove("translate-x-0");
    setTimeout(() => {
      // Chec-div logic if needed
    }, 1000);
    this.flag = true;
  }

  hideNotification() {
    setTimeout(() => {
      this.notificationTarget.classList.remove("translate-x-full");
      this.notificationTarget.classList.add("translate-x-0");
    }, 1000);
    // Chec-div logic if needed
    this.flag = false;
  }
}
