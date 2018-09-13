class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :owner, class_name: 'User'
  has_many :attachments, foreign_key: 'attacher_id', class_name: 'AnswerAttachment'

  accepts_nested_attributes_for :attachments, allow_destroy: true

  validates :body, presence: true
end
