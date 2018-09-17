class AnswerVote < Vote
  belongs_to :answer, foreign_key: 'vote_for_id', class_name: 'Answer', optional: true
end
