class Question < ApplicationRecord
  include Vuetable

  has_many :answers
  has_many :attachments, foreign_key: 'attacher_id', class_name: 'QuestionAttachment'
  has_many :votes, foreign_key: 'vote_for_id', class_name: 'QuestionVote'
  has_many :comments, foreign_key: 'comment_on_id', class_name: 'QuestionComment'
  has_many :subscribe_notifications

  alias_attribute :user_id, :owner_id

  belongs_to :owner, class_name: 'User'

  accepts_nested_attributes_for :attachments, allow_destroy: true

  validates :body, :title, presence: true

  after_create :publish_data_runtime, :add_owner_to_subscriber

  scope :created_today, -> { where('created_at >= ?', Time.zone.now.beginning_of_day) }

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

  def add_owner_to_subscriber
    SubscribeNotification.create(user_id: owner.id, question_id: id)
  end
end
