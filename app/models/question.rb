class Question < ApplicationRecord
  include Vuetable

  has_many :answers
  has_many :attachments, foreign_key: 'attacher_id', class_name: 'QuestionAttachment'
  has_many :votes, foreign_key: 'vote_for_id', class_name: 'QuestionVote'
  belongs_to :owner, class_name: 'User'

  accepts_nested_attributes_for :attachments, allow_destroy: true

  validates :body, :title, presence: true
end
