class Answer < ApplicationRecord
  include Vuetable

  belongs_to :question
  belongs_to :owner, class_name: 'User'
  has_many :attachments, foreign_key: 'attacher_id', class_name: 'AnswerAttachment'
  has_many :votes, foreign_key: 'vote_for_id', class_name: 'AnswerVote'
  has_many :comments, foreign_key: 'comment_on_id', class_name: 'AnswerComment'

  alias_attribute :user_id, :owner_id

  accepts_nested_attributes_for :attachments, allow_destroy: true

  validates :body, presence: true

  after_create :publish_data_runtime

  private

  def publish_data_runtime
    ActionCable.server.broadcast(
      'answers',
      ApplicationController.render(
        partial: 'answers/index',
        locals:  { question: question, current_user: owner }
      )
    )
  end
end
