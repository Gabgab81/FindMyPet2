if @comment.persisted?
    json.form render(partial: "comments/formEdit", formats: :html, locals: {advert: @advert, comment: Comment.new})
    # json.inserted_item render(partial: "shared/card-comment", formats: :html, locals: {comment: @comment})
else
    json.form render(partial: "comments/formEdit", formats: :html, locals: {advert: @advert, comment: @comment})
end