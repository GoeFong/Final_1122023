import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="daterangepicker"
export default class extends Controller {
  connect() {
    new DateRangePicker(this.element, {
      timePicker: true,
      alwaysShowCalendars: true,
      autoApply: false,
      showWeekNumbers: true,
      locale: {
        format: "DD-MM-YYYY HH:mm:ss",
      }
    });
  }
}
