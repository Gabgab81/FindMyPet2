import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="insert-in-list"
export default class extends Controller {
  static targets = ["items", "form"]

  connect() {
    console.log("I'm insert in list")
  }

  send(event){
    event.preventDefault()
    // console.log("send event", event);
    // console.log('form', this.formTarget.action)
    console.log('I was here in send')
    const url = this.formTarget.action
    console.log(this.formTarget)
    const option = {
      method: "post",
      headers: { "Accept": "application/json", "X-CSRF-Token": this.csrfToken },
      body: new FormData(this.formTarget)
    }

    fetch(url, option)
      .then(response => response.json())
      .then((data) => {
        console.log(data)
      })


  }
}
