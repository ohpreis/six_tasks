import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["editor", "wordCount"]

  connect() {
    // Ensure the word count is updated once the editor is fully initialized
    this.editorTarget.addEventListener("trix-initialize", this.updateWordCount.bind(this))

    // Listen for content changes in the editor
    this.editorTarget.addEventListener("trix-change", this.updateWordCount.bind(this))
  }

  updateWordCount() {
    // Get the text content from the Trix editor and strip any HTML
    const text = this.editorTarget.editor.getDocument().toString().trim()

    // Calculate the word count (splitting by spaces)
    const wordCount = text.length > 0 ? text.split(/\s+/).length : 0

    // Update the word count display
    let wordCountTarget = document.getElementById("word-count")
    wordCountTarget.textContent = `${wordCount} words`
  }
}
