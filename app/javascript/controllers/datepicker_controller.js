import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

// Connects to data-controller="datepicker"
export default class extends Controller {
  static targets = ["startDate", "endDate"]
  connect() {
    console.log("hello")
    const datePickrConfig = {

        enableTime: true,
        dateFormat: "Y-m-d H:i",
        time_24hr: true


    }
    console.log(this);
    console.log(this.startDateTarget);
    flatpickr(this.endDateTarget, datePickrConfig);
    flatpickr(this.startDateTarget, datePickrConfig);
}
}
