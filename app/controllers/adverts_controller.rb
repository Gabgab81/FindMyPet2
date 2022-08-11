class AdvertsController < ApplicationController
    before_action :set_advert, only: [:show, :edit, :update, :destroy]

    def new
        @advert = Advert.new
    end

    def create
        @advert = Advert.new(advert_params)
        @advert.user = current_user
        if @advert.save
            redirect_to advert_path(@advert)
        else
            render :new
        end
    end

    def index
        @adverts = Advert.all
    end

    def show
        
    end

    def edit
        
    end

    def upgrate
        @advert.update(advert_params)
        redirect_to advert_path(@advert)
    end

    def destroy
        @advert.destroy
    redirect_to adverts_path
    end

    private

    def advert_params
        params.require(:advert).permit(:type_ad, :name, :phone, :address, :content)
    end

    def set_advert
        @advert = Advert.find(params[:id])
    end

end
