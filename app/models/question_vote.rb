class QuestionVote < Vote
  belongs_to :question, foreign_key: 'vote_for_id', class_name: 'Question', optional: true
end
