class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :chat_group
  validates :text, presence: true, unless: :image?
  mount_uploader :image, ImageUploader
end
