class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :questions, foreign_key: 'owner_id', class_name: 'Question'
  has_many :answers, foreign_key: 'owner_id', class_name: 'Answer'
  has_many :answer_votes, foreign_key: 'voter_id', class_name: 'AnswerVote'
  has_many :question_votes, foreign_key: 'voter_id', class_name: 'QuestionVote'
  has_many :answer_comments, foreign_key: 'commenter_id', class_name: 'AnswerComment'
  has_many :question_comments, foreign_key: 'commenter_id', class_name: 'QuestionComment'
end
