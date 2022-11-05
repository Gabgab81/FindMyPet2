if @comment.persisted?
    json.form render(partial: "shared/comment-adv", formats: :html, locals: {advert: @advert, comment: @comment})
    json.inserted_item render(partial: "shared/card-comment", formats: :html, locals: {comment: comment})
  else
    json.form render(partial: "shared/comment-adv", formats: :html, locals: {advert: @advert, comment: @comment})
  end