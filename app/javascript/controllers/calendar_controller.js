import { Controller } from "@hotwired/stimulus"
import  { Calendar }  from "@fullcalendar/core";
import dayGridPlugin from '@fullcalendar/daygrid'

// Connects to data-controller="calendar"
export default class extends Controller {
  connect() {
    var calendarEl = document.getElementById('calendar');
    var calendar = new Calendar(calendarEl, {
      plugins: [dayGridPlugin],
      initialView: 'dayGridMonth'
    });
    calendar.render();
  }
}
