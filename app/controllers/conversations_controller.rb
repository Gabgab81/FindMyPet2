class ConversationsController < ApplicationController

    def show
        @conversation = Conversation.find(params[:id])
        @messages = Message.where(conversation_id: @conversation)
        @message = Message.new

    end

    def destroy
        @conversation = Conversation.find(params[:id])
        @conversation.destroy
        redirect_to conversations_path, status: :see_other
    end

end
