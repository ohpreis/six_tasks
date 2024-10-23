import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["content", "status", "error"];

  connect() {
    // Wrap the save function with debounce on connect
    this.debouncedSave = this.debounce(this.save.bind(this), 500);
  }

  save(event) {
    const form = event.target.closest("form");
    const data = new FormData(form);

    fetch(form.action, {
      method: "POST",
      body: data,
      headers: { "X-CSRF-Token": document.querySelector("[name='csrf-token']").content }
    })
      .then(response => {
        if (!response.ok) {
          this.showError();
          console.error("Autosave failed");
        } else {
            this.showStatus("Content saved");   
            this.hideError(); // Hide the error if it was previously shown
        }
      })
      .catch(error => {
        this.showError();
        console.error("Error:", error);
      });
  }

  showError() {
    this.errorTarget.style.display = "block"; // Show the error message
  }

  hideError() {
    this.errorTarget.style.display = "none"; // Hide the error message
  }

  // Simple debounce function
  debounce(func, wait) {
    let timeout;
    return function(...args) {
      const later = () => {
        clearTimeout(timeout);
        func(...args);
      };
      clearTimeout(timeout);
      timeout = setTimeout(later, wait);
    };
  }

  showStatus(message) {
    const statusTarget = document.getElementById("autosave-status");
    
    // Set the message and make it visible (fade-in)
    statusTarget.textContent = message;
    statusTarget.classList.remove("opacity-0");
    statusTarget.classList.add("opacity-100");
  
    // After 2 seconds, start the fade-out
    setTimeout(() => {
      statusTarget.classList.remove("opacity-100");
      statusTarget.classList.add("opacity-0");
    }, 2000);
  }
}
