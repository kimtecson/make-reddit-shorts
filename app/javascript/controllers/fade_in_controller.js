import { Controller } from "@hotwired/stimulus";
import ScrollReveal from "scrollreveal";

export default class extends Controller {
  connect() {
    ScrollReveal().reveal(this.element, {
      duration: 1000, // Time in milliseconds for the fade-in
      distance: '0px', // Move distance, if you don't want it to move
      origin: 'bottom', // Direction from which the element will appear
      opacity: 0, // Start with opacity 0 (completely transparent)
      easing: 'ease-in-out', // Easing function for the animation
      reset: false, // Animation happens only once
      delay: 200 // Delay before the animation starts
    });
  }
}
