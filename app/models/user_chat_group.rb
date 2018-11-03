class UserChatGroup < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :ChatGroup, optional: true
end
