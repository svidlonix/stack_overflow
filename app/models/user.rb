class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  has_many :authorizations
  has_many :questions, foreign_key: 'owner_id', class_name: 'Question'
  has_many :answers, foreign_key: 'owner_id', class_name: 'Answer'
  has_many :answer_votes, foreign_key: 'voter_id', class_name: 'AnswerVote'
  has_many :question_votes, foreign_key: 'voter_id', class_name: 'QuestionVote'
  has_many :answer_comments, foreign_key: 'commenter_id', class_name: 'AnswerComment'
  has_many :question_comments, foreign_key: 'commenter_id', class_name: 'QuestionComment'
  has_many :subscribe_notifications

  scope :visitors, -> { where(admin: false, manager: false) }

  def self.find_or_create_for_auth(auth)
    unless user = find_by(email: auth.info.email)
      user = User.create do |u|
        u.email = auth.info.email
        u.password = 'password'
        u.password_confirmation = 'password'
      end
    end
    user.authorizations.find_or_create_by(uid: auth.uid, provider: auth.provider)

    user
  end
end
