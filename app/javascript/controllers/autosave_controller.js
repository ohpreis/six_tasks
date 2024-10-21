import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["editor", "wordCount"]

  connect() {
    this.save = debounce(this.save.bind(this), 2000) // Save every 2 seconds of inactivity
    // this is an textarea else it's a trix-editor
    if (this.editorTarget.nodeName === "TEXTAREA") {
      this.editorTarget.addEventListener("input", this.save)
    } else {
      this.editorTarget.addEventListener("trix-change", this.save)
    }
  }

  save() {
    const url = this.data.get("url") + ".json"
    // const body = this.editorTarget.innerHTML
    let content = ""
    let body = ""
    if (url.includes("morning_page")) {
      content = this.editorTarget.innerHTML
      body = JSON.stringify({ morning_page: { body: content } })
    } else {
      content = this.editorTarget.value
      body = JSON.stringify({ task: { title: content } })
    }

    fetch(url, {
      method: "PUT",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
      body: body
    })
    .then(response => {
      if (!response.ok) {
        throw new Error("Network response was not ok")
      }
      showStatus("Content saved")
      return response.json()
    })
    .then(data => {
      console.log("Autosave successful", data)
    })
    .catch(error => {
      console.error("There was a problem with the autosave operation:", error)
    })
  }
}

// Simple debounce function
function debounce(func, wait) {
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

function showStatus(message) {
  const statusTarget = document.getElementById("autosave-status")
  statusTarget.textContent = message
  statusTarget.style.opacity = 1
  setTimeout(() => {
    statusTarget.style.transition = "opacity 1s"
    statusTarget.style.opacity = 0
  }, 1000)
}
