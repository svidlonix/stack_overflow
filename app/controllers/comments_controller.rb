class CommentsController < ApplicationController
  before_action :comment_on, only: %w[create destroy]
  after_action :publish_data_runtime, only: %w[create destroy]

  def create
    create_comment
  end

  def destroy
    delete_comment
  end

  private

  def create_comment
    @comment = Object.const_get("#{params[:comment][:type]}Comment").create(comment_params)
  end

  def delete_comment
    @comment = Object.const_get("#{params[:comment][:type]}Comment").find(params[:id]).destroy
  end

  def comment_params
    params.require(:comment).permit(:commenter_id, :comment_on_id, :text)
  end

  def comment_on
    @object = Object.const_get(params[:comment][:type]).find(params[:comment][:comment_on_id])
  end

  def publish_data_runtime
    if @comment.errors.present?
      ActionCable.server.broadcast(
        'comments',
        class:   '.alert',
        message: @comment.errors.full_messages.join(', ')
      )
    else
      ActionCable.server.broadcast(
        'comments',
        class:   object_comment_class,
        message: ApplicationController.render(
          partial: 'comments/comments',
          locals:  {object: @object, type: params[:comment][:type], current_user: current_user}
        )
      )
    end
  end

  def object_comment_class
    if @object.instance_of? Answer
      ".answer-comments-#{@object.id}"
    else
      '.question-comments'
    end
  end
end
