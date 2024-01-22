import { Controller } from "@hotwired/stimulus"
import Rails from "@rails/ujs";
// Connects to data-controller="form-element"
export default class extends Controller {
  static targets = ["remoteBtn"]
  connect() {
    this.remoteBtnTarget.hidden = true
  }

  autosubmit() {
    this.remoteBtnTarget.click()
  }
  autosubmitcongviec() {
    const prefixCongviecField = this.element;
    let timeoutId;
    // Lắng nghe sự kiện thay đổi
    prefixCongviecField.addEventListener("change", () => {
      clearTimeout(timeoutId); 
      timeoutId = setTimeout(() => {
        const prefixValue = $('#macongviec').val();
        console.log($('#macongviec').val());
        // Gửi yêu cầu kiểm tra đến server
        Rails.ajax({
          type: "GET",
          url: `/check_prefix_congviec?prefix_congviec=${encodeURIComponent(prefixValue)}`,
          success: (data) => {
            // Hiển thị thông báo tùy thuộc vào kết quả kiểm tra
            // alert(data.message);
            $('#ketquacheck').text(data.message);
          },
          error: (error) => {
            console.error("Error checking prefix_congviec:", error);
          },
        });
      }, 1400); // 3000 milliseconds = 3 seconds
    });
  }
}
