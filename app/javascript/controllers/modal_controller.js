import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content"]
  
  connect() {
    console.log("Modal controller connected")
    // Close modal on escape key
    this.boundEscapeHandler = this.handleEscape.bind(this)
    document.addEventListener("keydown", this.boundEscapeHandler)
    
    // Auto-open modal if it's visible
    if (this.element.classList.contains("flex")) {
      this.open()
    }
  }
  
  disconnect() {
    document.removeEventListener("keydown", this.boundEscapeHandler)
  }
  
  open() {
    this.element.classList.remove("hidden")
    this.element.classList.add("flex")
    document.body.style.overflow = "hidden"
    
    // Focus trap - focus first input
    setTimeout(() => {
      const firstInput = this.element.querySelector("input, textarea, select")
      if (firstInput) firstInput.focus()
    }, 100)
  }
  
  close() {
    console.log("Closing modal")
    this.element.classList.add("hidden")
    this.element.classList.remove("flex")
    document.body.style.overflow = ""
  }
  
  backdropClick(event) {
    // Close if clicking on the backdrop (not the modal content)
    if (event.target === this.element) {
      this.close()
    }
  }
  
  handleEscape(event) {
    if (event.key === "Escape") {
      this.close()
    }
  }
} 