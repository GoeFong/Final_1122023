// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "trix"
import "@rails/actiontext"

import jquery from "jquery"
window.jQuery = jquery
window.$ = jquery

import moment from 'moment'
window.moment = moment
import "chartkick/chart.js"