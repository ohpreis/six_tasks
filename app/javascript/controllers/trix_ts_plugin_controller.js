import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["editor"]

  connect() {
    this.editorTarget.addEventListener("trix-initialize", () => {
        this.addDateTimeButton()
        this.allowCustomUnderlineTag()
      })

    // Listen for the keyboard shortcut
    document.addEventListener("keydown", this.handleShortcut.bind(this))
  }

  disconnect() {
    // Clean up the event listener when the controller is disconnected
    document.removeEventListener("keydown", this.handleShortcut.bind(this))
  }

  // Handle the keyboard shortcut (Ctrl/Cmd + Alt + Z)
  handleShortcut(event) {
    const isMac = navigator.platform.toUpperCase().includes("MAC")
    const ctrlOrCmd = isMac ? event.metaKey : event.ctrlKey

    if (ctrlOrCmd && event.altKey && event.key === "z") {
      event.preventDefault() // Prevent default browser behavior
      this.insertDateTime()
    }
  }

  // Add the custom "Insert Date & Time" button to the Trix toolbar
  addDateTimeButton() {
    const toolbar = document.querySelector("trix-toolbar")

    if (toolbar) {
      const blockTools = toolbar.querySelector(".trix-button-group--block-tools")

      if (blockTools) {
        const buttonHTML = `
          <button type="button" class="trix-button" 
                  title="Insert Date & Time" 
                  data-action="click->trix-ts-plugin#insertDateTime">
            📅
          </button>`
        blockTools.insertAdjacentHTML("beforeend", buttonHTML)
        console.log("Date & Time button added to the toolbar.")
      } else {
        console.error("Block tools group not found.")
      }
    } else {
      console.error("Trix toolbar not found.")
    }
  }

   // Insert the current date & time with a custom class for underline styling
   insertDateTime() {
    const editor = this.editorTarget.editor
    const timestamp = this.getFormattedDateTime()

    // Insert the timestamp using a <span> with a custom class for underline styling
    const html = `<u class="timestamp">${timestamp}</u><br>`
    editor.insertHTML(html)
  }

  // Allow <span> with custom class as a valid Trix attribute
  allowCustomUnderlineTag() {
    Trix.config.textAttributes.customUnderline = {
      tagName: "u",
      inheritable: true,
      parser: (element) => element.tagName === "U" && element.classList.contains("timestamp")
    }
  }

  // Format the current date and time
  getFormattedDateTime() {
    const now = new Date()
    return now.toLocaleString() // Example: "10/22/2024, 10:15:30 AM"
  }
}
