class Question < ApplicationRecord
  include Vuetable

  has_many :answers
  has_many :attachments, foreign_key: 'attacher_id', class_name: 'QuestionAttachment'
  has_many :votes, foreign_key: 'vote_for_id', class_name: 'QuestionVote'
  has_many :comments, foreign_key: 'comment_on_id', class_name: 'QuestionComment'
  belongs_to :owner, class_name: 'User'

  accepts_nested_attributes_for :attachments, allow_destroy: true

  validates :body, :title, presence: true

  after_create :publish_data_runtime

  private

  def publish_data_runtime
    ActionCable.server.broadcast(
      'questions',
      ApplicationController.render(
        partial: 'questions/questions_list',
        locals:  { questions: Question.all }
      )
    )
  end
end
