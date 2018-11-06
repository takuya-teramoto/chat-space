class User < ApplicationRecord
  has_many :chats, dependent: :destroy
  has_many :UserChatGroups, dependent: :destroy
  has_many :ChatGroups, through: :UserChatGroups
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
