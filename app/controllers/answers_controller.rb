class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_answer, only: %w[show edit update destroy]

  respond_to :js

  def index
    @answers = Answer.all
  end

  def show; end

  def new
    @answer = Answer.new
  end

  def edit; end

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

  def load_answer
    @answer = Answer.find_by(id: params[:id])
  end

  def answer_params
    params.require(:answer).permit(
      :body,
      :question_id,
      :owner_id,
      attachments_attributes: %i[id file attacher_id _destroy]
    )
  end
end
