import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["sidebar"];
  connect() {
  }

  toggleSidebar() {
    const sidebar = document.getElementById('mainSidebar');
    sidebar.classList.toggle('-translate-x-full');
  }

  closeSidebar() {
    const sidebar = document.getElementById('mainSidebar');
    sidebar.classList.add('-translate-x-full');
  }
}