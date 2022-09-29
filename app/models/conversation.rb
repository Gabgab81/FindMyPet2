class Conversation < ApplicationRecord

    has_many :messages, dependent: :destroy
    has_many :UserConversations, dependent: :destroy

    has_many :users, through: :UserConversations

end
