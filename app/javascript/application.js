// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"

// app/javascript/application.js
import { Application } from "@hotwired/stimulus"

const application = Application.start()
