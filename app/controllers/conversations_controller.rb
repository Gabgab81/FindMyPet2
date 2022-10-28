class ConversationsController < ApplicationController

    def show
        @conversation = Conversation.find(params[:id])
        authorize @conversation
        @messages = Message.where(conversation_id: @conversation)
        @message = Message.new
        @message.user = current_user
        # raise
    end

    def destroy
        @conversation = Conversation.find(params[:id])
        authorize @conversation
        @conversation.destroy
        redirect_to conversations_path, status: :see_other
    end

end
