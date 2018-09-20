class AnswerComment < Comment
  belongs_to :answer, foreign_key: 'comment_on_id', class_name: 'Answer', optional: true
end
