import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="conversation-subscription"
export default class extends Controller {
  static values = { conversationId: Number, userId: Number }
  static targets = ["messages"]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "ConversationChannel", id: this.conversationIdValue },
      // { received: data => this.messagesTarget.insertAdjacentHTML("beforeend", data) }
      { 
        received: data => {
        
          const convTime = (time) => {
            return time.replace(/^(\d{4})-(\d{2})-(\d{2})(.+)/, "$3/$2/$1")
          }

          const createHtml = (data) => {
            if(this.userIdValue == data["user"]){
              return `
              <div id="message-${data["id"]}" >
                <div class="message-current">
                    <div class="current_user">
                        <p> ${data["content"]} </p>
                        <p class="date"> ${convTime(data["date"])} </p>
                    </div>
                </div>
              </div>`
            }else{
              return `
              <div id="message-${data["id"]}" >
                <div class="message-not-current">
                    <div class="not-current_user">
                        <p> ${data["content"]} </p>
                        <p class="date"> ${convTime(data["date"])}</p>
                    </div>
                </div>
              </div>`
            } 
          }
          this.messagesTarget.insertAdjacentHTML("beforeend", createHtml(data))
          // this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
          document.getElementById(`message-${data["id"]}`).scrollIntoView();
          console.log(this.messagesTarget)
          console.log(`message-${data["id"]}`)
        }

        
      } 
    )
    console.log(`Subscribe to the conversation with the id ${this.conversationIdValue}.`)
  }
  resetForm(event) {
    console.log('Im reset form')
    event.target.reset()
  }
}
