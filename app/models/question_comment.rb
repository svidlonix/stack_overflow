class QuestionComment < Comment
  belongs_to :question, foreign_key: 'comment_on_id', class_name: 'Question', optional: true
end
