import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="thongke"
export default class extends Controller {
  static targets = ["container"];

  connect() {
    console.log("ok");
  }

  showthongkecongviec() {
    const frame = document.getElementById("showthongke");
    frame.src = "/home/thongkecongviec?start_date_between="+ $("#rangethongke").val();
  }

  showthongkecongviec2() {
    const frame = document.getElementById("showthongke");
    frame.src = "/home/thongkecongviec2?start_date_between="+ $("#rangethongke").val();
  }
}
