import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "file" ]

  connect() {
    console.log("Video upload controller connected")
  }

  upload(event) {
    console.log("Upload method called")
    event.preventDefault()
    console.log("Default prevented")

    const formData = new FormData()
    formData.append("source[file]", this.fileTarget.files[0])

    console.log("Sending fetch request")
    fetch('/sources', {
      method: 'POST',
      body: formData,
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      }
    })
    .then(response => response.json())
    .then(data => {
      console.log('Upload successful:', data)
    })
    .catch(error => {
      console.error('Error:', error)
    })
  }
}
