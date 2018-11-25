class ChatGroup < ApplicationRecord
  has_many :chats, dependent: :destroy
  has_many :UserChatGroups, dependent: :destroy
  has_many :users, through: :UserChatGroups

  validates :name, presence: true

  accepts_nested_attributes_for :UserChatGroups, allow_destroy: true
end
