class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :advert

  validates :content, presence: true, length: { minimum: 2 }
end
