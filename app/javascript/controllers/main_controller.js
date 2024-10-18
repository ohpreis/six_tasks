import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["sidebar", "drawer"];
  connect() {
    window.addEventListener('resize', () => {
      if (window.innerWidth >= 768) {
        this.drawerTarget.classList.remove('open');
      }
    })
  }

  toggleDrawer() {
    const drawer = document.getElementById('drawer');
    drawer.classList.toggle('open');
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