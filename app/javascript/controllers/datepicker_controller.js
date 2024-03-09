import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

// Connects to data-controller="datepicker"
export default class extends Controller {

  connect() {
    console.log("hello")
    const datePickrConfig = {

        enableTime: true,
        dateFormat: "Y-m-d H:i"


    }
    console.log(this);
    console.log(this.startDateTarget);
    flatpickr(this.endDateTarget, datePickrConfig);
    flatpickr(this.startDateTarget, datePickrConfig);
}
}
