module VotesHelper
  def update_ajax_data(object)
    if object.instance_of? Answer
      ".answer-vote-#{object.id}"
    else
      '.question-vote'
    end
  end
end
