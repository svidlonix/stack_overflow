class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :body, :user_id, :question_id
  has_many :comments
end
