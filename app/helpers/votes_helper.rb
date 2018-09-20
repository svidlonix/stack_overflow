module VotesHelper
  def object_vote_class(object)
    if object.instance_of? Answer
      ".answer-vote-#{object.id}"
    else
      '.question-vote'
    end
  end
end
