class User < ApplicationRecord
  has_many :chats
  has_many :chat_groups, through: :user_chat_groups
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
