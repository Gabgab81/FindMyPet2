if @comment.persisted?
  json.form render(partial: "comments/form", formats: :html, locals: {advert: @advert, comment: Comment.new})
  json.inserted_item render(partial: "shared/card-comment", formats: :html, locals: {comment: @comment})
else
  json.form render(partial: "comments/form", formats: :html, locals: {advert: @advert, comment: @comment})
end