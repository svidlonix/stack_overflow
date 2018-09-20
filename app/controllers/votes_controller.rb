class VotesController < ApplicationController
  before_action :voter_for, only: %w[create destroy]

  respond_to :js

  def create
    @object.votes.create(vote_params.merge(vote: params[:commit].parameterize.underscore))
    respond_with(@object)
  end

  def destroy
    respond_with(@object.votes.find(params[:id]).destroy)
  end

  private

  def vote_params
    params.require(:vote).permit(:voter_id, :vote_for_id)
  end

  def voter_for
    @object = Object.const_get(params[:vote][:type]).find(params[:vote][:vote_for_id])
  end
end
