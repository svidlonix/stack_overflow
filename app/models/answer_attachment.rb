class AnswerAttachment < Attachment
  belongs_to :answer, foreign_key: 'attacher_id', class_name: 'Answer', optional: true
end
