import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="vanban"
export default class extends Controller {

  connect() {
    $("#check-canbo").change(function() {
      if (this.checked) {

          $("#canbos").show();
        } else {
          $("#canbos").hide();

        }
      });
  }
}
