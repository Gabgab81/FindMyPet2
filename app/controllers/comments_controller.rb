class CommentsController < ApplicationController
    before_action :set_comment, only: [:edit, :update, :destroy]

    def create
        @comment = Comment.new(comment_params)
        @comment.user = current_user
        @comment.advert = Advert.find(params[:advert_id])
        @comment.save
        redirect_to advert_path(@comment.advert)
    end

    def edit
        # @comment = Comment.find(params[:id])
    end


    def update
        # @comment = Comment.find(params[:id])
        @comment.update(comment_params)
        redirect_to advert_path(@comment.advert)
    end

    def destroy
        @advert = @comment.advert
        @comment.destroy
        redirect_to advert_path(@advert)
    end


    private

    def comment_params
        params.require(:comment).permit(:content)
    end

    def set_comment
        @comment = Comment.find(params[:id])
    end


end
