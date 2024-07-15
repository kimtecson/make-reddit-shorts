import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form"]

  connect() {
    console.log("Submit controller connected");
  }

  submit(event) {
    event.preventDefault();
    console.log("Form submission prevented");

    const formData = new FormData(this.formTarget);

    for (const [key, value] of formData.entries()) {
      console.log(`${key}: ${value} t`);
    }


    console.log("Sending fetch request");
    fetch(this.formTarget.action, {
      method: this.formTarget.method,
      body: formData,
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      }
    })
    .then(response => {
      if (!response.ok) {
        console.log('Response not ok:', response);
      }
      return response.json()
    })
    .then(data => {
      console.log('Submission successful:', data);
    })
    .catch(error => {
      console.error('Error:', error);
    });
  }
}
