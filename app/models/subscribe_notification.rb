class SubscribeNotification < ApplicationRecord
  belongs_to :user
  belongs_to :question, touch: true
end
