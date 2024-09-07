// voice_speed_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["speedValue", "voiceSpeedHidden", "slider"]

  updateSpeedLabel(event) {
    const percentage = this.sliderTarget.value;

    // Update the displayed percentage
    this.speedValueTarget.textContent = `${percentage}%`;

    // Update the hidden input value with the percentage
    this.voiceSpeedHiddenTarget.value = percentage;
  }
}
