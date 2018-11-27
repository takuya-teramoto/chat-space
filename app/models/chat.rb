class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :ChatGroup
  validates :text, presence: true, unless: :image?
  mount_uploader :image, ImageUploader
end
