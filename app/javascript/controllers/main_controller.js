import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["sidebar"];
  connect() {
  }

  toggleSidebar() {
    const sidebar = document.getElementById('mainSidebar');
    sidebar.classList.remove('hidden');
  }

  closeSidebar() {
    const sidebar = document.getElementById('mainSidebar');
    sidebar.classList.add('hidden');
  }
}