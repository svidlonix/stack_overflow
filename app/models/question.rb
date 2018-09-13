class Question < ApplicationRecord
  has_many :answers
  belongs_to :owner, class_name: 'User'

  validates :body, :title, presence: true
end
