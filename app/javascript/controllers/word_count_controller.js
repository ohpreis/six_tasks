import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content", "wordCount"]

  connect() {
    // Ensure the word count is updated once the editor is fully initialized
    this.contentTarget.addEventListener("trix-initialize", this.updateWordCount.bind(this))

    // Listen for content changes in the editor
    this.contentTarget.addEventListener("trix-change", this.updateWordCount.bind(this))
  }

  updateWordCount() {
    // Get the text content from the Trix editor and strip any HTML
    const text = this.contentTarget.editor.getDocument().toString().trim()

    // Calculate the word count (splitting by spaces)
    // const wordCount = text.length > 0 ? text.split(/\s+/).length : 0
    const wordCount = this.countWords(text)

    // Update the word count display
    let wordCountTarget = document.getElementById("word-count")
    wordCountTarget.textContent = `${wordCount} words`
  }

  countWords(s){
    s = s.replace(/(^\s*)|(\s*$)/gi,"");//exclude  start and end white-space
    s = s.replace(/[ ]{2,}/gi," ");//2 or more space to 1
    s = s.replace(/\n /,"\n"); // exclude newline with a start spacing
    // exlude - and and any text decorators like ?!`=+ that stand alone
    s = s.replace(/[-`~!@#$%^&*()_|+=?;:'",.<>\{\}\[\]\\\/]/gi,"");
    return s.split(' ').filter(function(str){return str!="";}).length;
    //return s.split(' ').filter(String).length; - this can also be used
  }
}
