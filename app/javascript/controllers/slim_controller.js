import { Controller } from "@hotwired/stimulus"
import SlimSelect from 'slim-select'

// Connects to data-controller="slim"
export default class extends Controller {
  connect() {
    new SlimSelect({
      select: this.element
      
    })

    const selectBox = document.getElementById("vanban_id"); // Thay thế bằng ID của select box
    const form = document.getElementById("search-form");
    if(form)
      selectBox.addEventListener("change", function () {
        // Thực hiện action "search" dựa trên selectedValue
        // Ví dụ: gửi Ajax request để tìm kiếm dữ liệu
        form.requestSubmit();
      });

  }
  
}
