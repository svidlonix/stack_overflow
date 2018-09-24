class CommentsController < ApplicationController
  before_action :comment_on, only: %w[create destroy]

  respond_to :js

  def create
    @comment = @object.comments.create(comment_params)
    respond_with(@comment)
  end

  def destroy
    respond_with(@object.comments.find(params[:id]).destroy)
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter_id, :comment_on_id, :text)
  end

  def comment_on
    @object = Object.const_get(params[:comment][:type]).find(params[:comment][:comment_on_id])
  end
end
