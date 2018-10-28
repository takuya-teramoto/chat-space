class ChatGroup < ApplicationRecord
  has_many :chats
  has_many :users, through: :user_chat_groups
end
