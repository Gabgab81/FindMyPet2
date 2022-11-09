import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="insert-in-list"
export default class extends Controller {
  static values = {commentId: Number}
  static targets = ["items", "form", "edit"]

  connect() {
    console.log("I'm insert in list")
    // console.log("edit :", this.editTarget)
  }

  send(event){
    event.preventDefault()
    // console.log("send event", event);
    // console.log('form', this.formTarget.action)
    const url = this.formTarget.action
    // console.log(this.formTarget)
    const option = {
      method: "post",
      headers: { "Accept": "application/json", "X-CSRF-Token": this.csrfToken },
      body: new FormData(this.formTarget)
    }
    console.log("commentId", this.commentIdValue)

    fetch(url, option)
      .then(response => response.json())
      .then((data) => {
        // console.log("data: ", data)
        if (data.inserted_item) {
          this.itemsTarget.insertAdjacentHTML("beforeend", data.inserted_item)
        }
        // console.log("outerHTML: ", this.formTarget.outerHTML)
        // console.log("data.form: ", data.form)
        // console.log("data: ", data)
        this.formTarget.outerHTML = data.form
      })
  }
  update(event){
    // console.log("Update")
    // console.log(event)
    // event.preventDefault()

    // console.log("update event", event)
    // console.log("edit: ", this.editTarget.action)
    // console.log("commentId", this.commentIdValue)
    // console.log("form for commentId", this.editTarget)

    // const url = this.editTarget.action
    // console.log('this.editTarget.action : ', this.editTarget.action)
    // const option = {
    //   method: "post",
    //   headers: { "Accept": "application/json"},
    //   body: new FormData(this.editTarget)
    // }

    // fetch(url, option)
    //   .then(response => response.json())
    //   .then((data) => {
    //     console.log("data: ", data)
    //   })

  }
}
