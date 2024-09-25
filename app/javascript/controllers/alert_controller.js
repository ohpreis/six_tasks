// app/javascript/controllers/alert_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["alert", "notice"];

  closeAlert() {
    this.alertTarget.remove();
  }

  closeNotice() {
    this.noticeTarget.remove();
  }
}