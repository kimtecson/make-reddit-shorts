import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  connect() {
    console.log("Video upload controller connected")
    console.log("Input target exists:", this.hasInputTarget)
  }

  upload() {
    console.log("Upload method called")
    console.log("Input target:", this.inputTarget)

    if (this.hasInputTarget) {
      if (this.inputTarget.files.length > 0) {
        // Find the closest form element from the input target
        const formElement = this.inputTarget.closest('form');
        if (formElement) {
          const formData = new FormData(formElement);

          // Log each form data entry
          for (let [key, value] of formData.entries()) {
            console.log(`${key}: ${value}`);
          }

          fetch(formElement.action, {
            method: 'POST',
            body: formData,
            headers: {
              'X-Requested-With': 'XMLHttpRequest'
            }
          })
          .then(response => {
            if (!response.ok) {
              throw new Error(`HTTP error! status: ${response.status}`);
            }
            return response.text();  // Use text() instead of json()
          })
          .then(responseText => {
            try {
              const data = JSON.parse(responseText);
              console.log('Upload successful:', data);
              // Handle successful upload (e.g., show a success message)
            } catch (error) {
              console.error('Failed to parse JSON:', responseText);
              // Handle non-JSON response
            }
          })
          .catch(error => {
            console.error('Error:', error);
            // Handle upload error
          });
        } else {
          console.error("No form element found");
        }
      }
    } else {
      console.error("Input target is missing");
    }
  }
}
