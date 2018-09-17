class QuestionAttachment < Attachment
  belongs_to :question, foreign_key: 'attacher_id', class_name: 'Question', optional: true

  def file_name
    'sdvsvdvdsv'
  end
end
