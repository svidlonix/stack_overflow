class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :questions, foreign_key: 'owner_id', class_name: 'Question'
  has_many :answers, foreign_key: 'owner_id', class_name: 'Answer'
end
