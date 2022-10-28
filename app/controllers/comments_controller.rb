class CommentsController < ApplicationController
    before_action :set_comment, only: [:edit, :update, :destroy]

    def create
        @comment = Comment.new(comment_params)
        authorize @comment
        @comment.user = current_user
        @comment.advert = Advert.find(params[:advert_id])
        @comment.save
        redirect_to advert_path(@comment.advert)
    end

    def edit
        # @comment = Comment.find(params[:id])
        @advert = @comment.advert
        @adverts = Advert.where(id: @comment.advert.id)
        @message = Message.new
        @markers = @adverts.geocoded.map do |advert|
            {
                lat: advert.latitude,
                lng: advert.longitude,
                info_window: render_to_string(partial: "shared/info_window", locals: {advert: advert})
                # image_url: helpers.asset_url("/cartoon-dogs1.png")
            }
        end
    end


    def update
        # @comment = Comment.find(params[:id])
        @comment.update(comment_params)
        redirect_to advert_path(@comment.advert)
    end

    def destroy
        @advert = @comment.advert
        @comment.destroy
        # raise
        # redirect_to advert_path(@comment.advert)
        redirect_to advert_path(@advert), status: :see_other
    end


    private

    def comment_params
        params.require(:comment).permit(:content)
    end

    def set_comment
        @comment = Comment.find(params[:id])
        authorize @comment
    end


end
