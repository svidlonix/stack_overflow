class Comment < ApplicationRecord
  belongs_to :commenter, foreign_key: 'commenter_id', class_name: 'User'

  validates :text, presence: true
end
