import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form"]

  connect() {
    console.log("Submit controller connected");
  }

  submit(event) {
    event.preventDefault();
    console.log("Submit function called");

    const formData = new FormData(this.formTarget);

    // Log form data
    for (let [key, value] of formData.entries()) {
      console.log(key, value);
    }

    fetch(this.formTarget.action, {
      method: this.formTarget.method,
      body: formData,
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
        'Accept': 'application/json'
      }
    })
    .then(response => {
      console.log('Response status:', response.status);
      console.log('Response headers:', response.headers);
      return response.text();  // Change this from response.json()
    })
    .then(text => {
      console.log('Response text:', text);
      try {
        const data = JSON.parse(text);
        console.log('Parsed JSON:', data);
      } catch (error) {
        console.error('Error parsing JSON:', error);
      }
    })
    .catch(error => {
      console.error('Fetch error:', error);
    });
  }
}
