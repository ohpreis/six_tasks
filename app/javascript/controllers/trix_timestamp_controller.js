import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["editor"]

  connect() {
    // Ensure the timestamp button is added after Trix initializes
    this.editorTarget.addEventListener("trix-initialize", () => {
      this.addTimestampButton()
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
      event.preventDefault() // Prevent any default browser behavior
      this.insertTimestamp()
    }
  }

  // Insert the timestamp at the cursor's location
  insertTimestamp() {
    const editor = this.editorTarget.editor
    const timestamp = this.getFormattedTimestamp()
    const html = `<strong class="small-text">${timestamp}</strong>`

    const tsAttachment = new Trix.Attachment({ content: `<span class="small-text">${timestamp}</span>` })
    editor.insertAttachment(tsAttachment)
  }

  // Add the custom timestamp button to the Trix toolbar
  addTimestampButton() {
    const toolbar = document.getElementById("trix-toolbar-1")

    if (toolbar) {
      const blockTools = toolbar.querySelector(".trix-button-group--block-tools")

      if (blockTools) {
        const buttonHTML = `
          <button type="button" class="trix-button" 
                  title="Insert Timestamp" 
                  data-action="click->trix-timestamp#insertTimestamp">
            TS
          </button>`
        blockTools.insertAdjacentHTML("beforeend", buttonHTML)
        console.log("Timestamp button added to the toolbar.")
      } else {
        console.error("Block tools group not found.")
      }
    } else {
      console.error("Trix toolbar not found.")
    }
  }

  // Format the current timestamp
  getFormattedTimestamp() {
    const now = new Date()
    return now.toLocaleString() // Example: "10/21/2024, 9:15:30 AM"
  }
}
