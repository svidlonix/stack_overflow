module Vuetable
  extend ActiveSupport::Concern

  Vote.votes.keys.each do |attribute|
    define_method(attribute) do
      votes.where(vote: attribute).count
    end
  end

  define_method(:user_vote) do |user|
    votes.where(voter_id: user.id).first
  end
end
