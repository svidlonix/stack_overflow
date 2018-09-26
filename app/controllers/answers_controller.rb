class AnswersController < ApplicationController
  before_action :authenticate_user!

  load_and_authorize_resource

  respond_to :js

  def create
    @question = Question.find_by(id: params[:answer][:question_id])
    respond_with(@answer = Answer.create(answer_params))
  end

  def update
    @answer.update(answer_params)
    respond_with(@answer)
  end

  def destroy
    respond_with(@answer.destroy)
  end

  private

  def answer_params
    params.require(:answer).permit(
      :body,
      :question_id,
      :owner_id,
      attachments_attributes: %i[id file attacher_id _destroy]
    )
  end
end
