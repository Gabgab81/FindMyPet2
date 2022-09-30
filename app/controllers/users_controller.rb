class UsersController < ApplicationController
    before_action :set_user, only: [:show, :user_adverts]


    def show
        # raise
    end

    def user_adverts
        # @adverts = Advert.where(user_id: @user)
        @adverts = @user.adverts
    end

    def set_user
        # @user = User.find(params[:id])
        @user = User.find(current_user[:id])
    end

end
