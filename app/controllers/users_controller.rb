class UsersController < ApplicationController
    before_action :set_user, only: [:show, :user_adverts]


    def show
        # raise
    end

    def user_adverts
        # @adverts = Advert.where(user_id: @user)
        # @adverts = @user.adverts
        if !params[:type_ad].nil? && params[:type_ad] != ''
            @adverts = @user.adverts.where(type_ad: params[:type_ad])
        else
            @adverts = @user.adverts
        end
        # raise 
    end

    def set_user
        # @user = User.find(params[:id])
        @user = User.find(current_user[:id])
    end

end
