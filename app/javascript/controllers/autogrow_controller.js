// app/javascript/controllers/autogrow_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.resize();
    window.addEventListener("resize", this.resize.bind(this));
  }

  disconnect() {
    window.removeEventListener("resize", this.resize.bind(this));
  }

  resize() {
    const taskBody = this.element;
    taskBody.style.height = "auto";

    const isMobile = window.innerWidth < 768;
    const maxHeight = isMobile ? window.innerHeight * 0.5 : window.innerHeight * 0.75;

    console.log("Window width:", window.innerWidth);
    console.log("Is mobile:", isMobile);
    console.log("Max height:", maxHeight);
    console.log("Scroll height:", taskBody.scrollHeight);

    taskBody.style.height = `${Math.min(taskBody.scrollHeight, maxHeight)}px`;

    console.log("Final height:", taskBody.style.height);
  }
}