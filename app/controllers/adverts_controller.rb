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
        # @adverts = Advert.all
        # @adverts = Advert.where(type_ad: params[:type_ad])
        if !params[:address].nil? && params[:address] != ''
            if !params[:type_ad].nil? && params[:type_ad] != ''
                @adverts = Advert.near(params[:address], params[:distance].to_i).where(type_ad: params[:type_ad])
            else
               @adverts = Advert.near(params[:address], params[:distance].to_i)
            end
        elsif !params[:type_ad].nil? && params[:type_ad] != ''
            @adverts = Advert.where(type_ad: params[:type_ad])
        else
            @adverts = Advert.all
        end
        @markers = @adverts.geocoded.map do |advert|
            {
                lat: advert.latitude,
                lng: advert.longitude,
                info_window: render_to_string(partial: "shared/info_window", locals: {advert: advert})
                # image_url: helpers.asset_url("/cartoon-dogs1.png")
            }
        end
        # raise
    end

    def show
        # if @advert.geocoded?
        #     @markers = 
        #         [{
        #             lat: @advert.latitude,
        #             lng: @advert.longitude,
        #             info_window: render_to_string(partial: "info_window", locals: {advert: @advert})
        #             # image_url: helpers.asset_url("/cartoon-dogs1.png")
        #         }]
        # else
        #     console.log('no coordinate for this advert')
        # end
        @adverts = Advert.where(id: @advert.id)
        @comment = Comment.new
        @message = Message.new
        @markers = @adverts.geocoded.map do |advert|
            {
                lat: advert.latitude,
                lng: advert.longitude,
                info_window: render_to_string(partial: "shared/info_window", locals: {advert: advert})
                # image_url: helpers.asset_url("/cartoon-dogs1.png")
            }
        end
        # raise
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
        params.require(:advert).permit(:type_ad, :name, :phone, :address, :content, photos: [])
    end

    def set_advert
        @advert = Advert.find(params[:id])
    end

end
