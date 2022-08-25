class UserConversationsController < ApplicationController

    def index
        @userConversations = UserConversation.where(user_id: current_user)
    end

end
