class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :adverts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :UserConversations, dependent: :destroy
  has_one_attached :photo

  has_many :conversations, through: :UserConversations

  validates :name, presence: true, length: { minimum: 3 }
  validate :password_regex

  def password_regex
    return if password.blank? || password =~ /\A(?=.*\d)(?=.*[A-Z])(?=.*\W)[^ ]{8,}\z/

    errors.add :password, 'Password should have more than 7 characters including 1 uppercase letter, 1 number, 1 special character'
  end

end
