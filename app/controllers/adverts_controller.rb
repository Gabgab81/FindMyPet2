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
            render :new, status: :unprocessable_entity
        end
    end

    def index
        @adverts = Advert.all
        @markers = @adverts.geocoded.map do |advert|
            {
                lat: advert.latitude,
                lng: advert.longitude,
                info_window: render_to_string(partial: "info_window", locals: {advert: advert})
                # image_url: helpers.asset_url("/cartoon-dogs1.png")
            }
        end
    end

    def show
        
    end

    def edit
        
    end

    def update
        if @advert.update(advert_params)
            redirect_to advert_path(@advert)
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @advert.destroy
        
        redirect_to adverts_path, status: :see_other
    end

    private

    def advert_params
        params.require(:advert).permit(:type_ad, :name, :phone, :address, :content)
    end

    def set_advert
        @advert = Advert.find(params[:id])
    end

end
