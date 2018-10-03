class QuestionComment < Comment
  belongs_to :question, foreign_key: 'comment_on_id', class_name: 'Question', optional: true, touch: true

  after_create :publish_question_comment_runtime

  private

  def publish_question_comment_runtime
    publish_data_runtime(question, 'Question', '.question-comments')
  end
end
