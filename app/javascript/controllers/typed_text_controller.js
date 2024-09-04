import { Controller } from "@hotwired/stimulus";
import Typed from "typed.js";

export default class extends Controller {
  connect() {
    const options = {
      strings: ["<span style='color: #e859ea;'>Reels</span>", "<span style='color: #44c4c0;'>TikToks</span>", "<span style='color: #EF2950;'>Shorts</span>"],
      typeSpeed: 50,
      backSpeed: 25,
      loop: false,
      backDelay: 1000,
      startDelay: 1000,
      showCursor: true,
      onComplete: (self) => {
        self.cursor.remove();
      }
    };

    new Typed(this.element, options);
  }
}
