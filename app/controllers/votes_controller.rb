class VotesController < ApplicationController
  before_action :voter_for, only: %w[create destroy]

  def create
    case params[:commit]
    when 'Vote Against'
      create_vote(0)
    when 'Vote For'
      create_vote(1)
    end
  end

  def destroy
    delete_vote
  end

  private

  def create_vote(vote)
    Object.const_get("#{params[:vote][:type]}Vote").create(vote_params.merge(vote: vote))
  end

  def delete_vote
    Object.const_get("#{params[:vote][:type]}Vote").find(params[:id]).destroy
  end

  def vote_params
    params.require(:vote).permit(:voter_id, :vote_for_id)
  end

  def voter_for
    @object = Object.const_get(params[:vote][:type]).find(params[:vote][:vote_for_id])
  end
end
