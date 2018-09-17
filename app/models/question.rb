class Question < ApplicationRecord
  has_many :answers
  has_many :attachments, foreign_key: 'attacher_id', class_name: 'QuestionAttachment'
  belongs_to :owner, class_name: 'User'

  accepts_nested_attributes_for :attachments, allow_destroy: true

  validates :body, :title, presence: true
end
