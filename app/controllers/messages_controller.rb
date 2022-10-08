class MessagesController < ApplicationController

    def create
        @message = Message.new(message_params)
        @message.user = current_user
        
        if params[:message][:conversation_id] == ''
            
            @conversation = Conversation.create
            @message.conversation = @conversation

            @conversation_current_user = UserConversation.new
            @conversation_current_user.user = current_user
            @conversation_current_user.conversation = @conversation

            @conversation_advert_user = UserConversation.new
            @conversation_advert_user.user = User.find(params[:message][:advert_user_id])
            @conversation_advert_user.conversation = @conversation
        else
            @message.conversation = Conversation.find(params[:message][:conversation_id])
            @conversation = nil
        end
        
        if @message.save
            if @conversation
                @conversation_current_user.save
                @conversation_advert_user.save
                redirect_to conversation_path(@message.conversation_id)
            else
                ConversationChannel.broadcast_to(
                @message.conversation, {content: @message.content, id: @message.id, user: @message.user.id, date: @message.created_at})
            end
            # ConversationChannel.broadcast_to(
            #     @message.conversation, {content: @message.content, id: @message.id, user: @message.user.id, date: @message.created_at})
                # render_to_string(partial: "conversations/message", locals: {message: @message})
                # )
                # head :ok
            # raise
            # redirect_to conversation_path(@message.conversation_id)
        else
            if @conversation
                @conversation.destroy
            end
            redirect_to :back
        end
    end

# end

private

    def message_params
        params.require(:message).permit(:content)
    end

end
