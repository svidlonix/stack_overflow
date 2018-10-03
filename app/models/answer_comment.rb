class AnswerComment < Comment
  belongs_to :answer, foreign_key: 'comment_on_id', class_name: 'Answer', optional: true, touch: true

  after_create :publish_qanswern_comment_runtime

  private

  def publish_qanswern_comment_runtime
    publish_data_runtime(answer, 'Answer', ".answer-comments-#{id}")
  end
end
