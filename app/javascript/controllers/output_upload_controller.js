import { Controller } from "@hotwired/stimulus"

console.log("Output upload controller loaded - version 1.0"); // Add this line

export default class extends Controller {
  static targets = ["form"]

  connect() {
    console.log("Output upload controller connected");
  }

  submit(event) {
    event.preventDefault();
    console.log("Submit function called - version 1.0"); // Update this line

    const formData = new FormData(this.formTarget);

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
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      return response.json();
    })
    .then(data => {
      console.log('Response data:', data);
      if (data.redirect_url) {
        window.location.href = data.redirect_url;
      } else if (data.errors) {
        console.error('Errors:', data.errors);
        // You might want to update the UI to show these errors
      }
    })
    .catch(error => {
      console.error('Fetch error:', error);
      // Handle the error (e.g., show an error message to the user)
    });
  }
}