class UserChatGroup < ApplicationRecord
  belongs_to :user
  belongs_to :ChatGroup
end
