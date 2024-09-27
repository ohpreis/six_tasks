import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["editor", "wordCount"]

  connect() {
    this.updateWordCount() // Initialize the word count on page load
  }

  updateWordCount() {
    const text = this.editorTarget.value.trim()
    const wordCount = text.length > 0 ? text.split(/\s+/).length : 0
    this.wordCountTarget.textContent = `${wordCount} words`
  }
}
