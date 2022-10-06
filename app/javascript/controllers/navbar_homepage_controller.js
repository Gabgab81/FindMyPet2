import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar-homepage"
export default class extends Controller {
  static targets = ["logoposition", "logo", "search", "img"]
  connect() {
    // console.log("Im connect")
    console.log(this.imgTarget.style)
    if (window.location.pathname == '/') {
      this.element.dataset.action = "scroll@window->navbar-homepage#scroll"
    } else {
      this.element.dataset.action = ""
    }
  }

  // initialize(){
  //   console.log("Im initialize")
  // }

  scroll(){
    // console.log("scrolling")
    if(window.scrollY < 10){
      this.logopositionTarget.classList.replace("transition", "home")
      this.logoTarget.classList.replace("transition", "home")
      this.searchTarget.classList.replace("transition", "home")
      this.imgTarget.classList.remove("transition")
    }else if (window.scrollY < 100){
      // console.log("I'm over 10")
      this.logopositionTarget.classList.replace("home", "transition")
      this.logoTarget.classList.replace("home", "transition")
      this.searchTarget.classList.replace("home", "transition")
      this.imgTarget.classList.add("transition")
    }
  }

}
