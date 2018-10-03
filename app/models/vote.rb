class Vote < ApplicationRecord
  belongs_to :voter, foreign_key: 'voter_id', class_name: 'User', touch: true

  validates_uniqueness_of :voter_id, scope: %i[vote_for_id type]

  enum vote: %i[vote_against vote_for]
end
