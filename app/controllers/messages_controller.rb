class MessagesController < ApplicationController

    def create
        # @user_text = UserText.new(user_text_params)
        # @user_text.user = current_user
        
        # if params[:user_text][:conversation_id] == ''
            
        #     @conversation = Conversation.create
        #     @user_text.conversation = @conversation

        #     @conversation_current_user = ConversationUser.new
        #     @conversation_current_user.user = current_user
        #     @conversation_current_user.conversation = @conversation

        #     @conversation_advert_user = ConversationUser.new
        #     @conversation_advert_user.user = User.find(params[:user_text][:advert_user_id])
        #     @conversation_advert_user.conversation = @conversation
        # else
        #     @user_text.conversation = Conversation.find(params[:user_text][:conversation_id])
        #     @conversation = nil
        # end

        # if @user_text.save
        #     if @conversation
        #         @conversation_current_user.save
        #         @conversation_advert_user.save
        #     end
        #     redirect_to conversation_path(@user_text.conversation_id)
        # else
        #     if @conversation
        #         @conversation.destroy
        #     end
        #     redirect_to :back
        # end
        
    end

end

private

    def user_text_params
        params.require(:user_text).permit(:content)
    end

end
