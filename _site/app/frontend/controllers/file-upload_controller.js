import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ "file-upload","output" ]
  connect() {
    this.fileInput = this.element.querySelector(".file-input");
    this.fileNameDisplay = this.element.querySelector(".file-name");

    if (this.fileInput) {
      this.fileInput.addEventListener("change", this.handleFileChange.bind(this));
    }
  }

  handleFileChange() {
    if (this.fileInput && this.fileInput.files.length > 0) {
      this.fileNameDisplay.textContent = this.fileInput.files[0].name;
    }
  }
}


