import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="eventcreation"
export default class extends Controller {
  static trargets = ["items", "form"]
  connect() {
    console.log("hello from the event controller")
    console.log(this.itemsTarget)
    console.log(this.formTarget)
  }

  send(event){
    event.preventDefault();

    // new event
    fetch()
  }
}
