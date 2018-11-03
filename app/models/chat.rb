class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :chat_group
  validates :text, presence: true
end
