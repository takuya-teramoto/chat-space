class ChatGroup < ApplicationRecord
  has_many :chats
  has_many :UserChatGroups
  has_many :users, through: :UserChatGroups

  accepts_nested_attributes_for :UserChatGroups
end
