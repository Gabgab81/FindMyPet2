class Advert < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  belongs_to :user
  # has_many :messages, dependent: :destroy
  # has_many_attached :photos

  validates :name, presence: true, length: { minimum: 2 }
  validates :type_ad, presence: true, inclusion:  { in: ["Lost", "Find", "See"], 
    message: "%{value} is not a valid type" }
  validates :address, presence: true
  validates :content, presence: true

end
