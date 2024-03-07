// avatar_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "image"];

  openFilePicker() {
    this.inputTarget.click();
  }

  changeAvatar(event) {
    const file = event.target.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = (e) => {
        this.imageTarget.src = e.target.result;
      };
      reader.readAsDataURL(file);
    }
  }
}
