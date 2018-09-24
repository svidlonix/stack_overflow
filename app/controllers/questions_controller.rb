class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question, only: %w[show edit update destroy]

  def index
    @questions = Question.all
    respond_with(@questions)
  end

  def show; end

  def new
    @question = Question.new
    respond_with(@questions)
  end

  def edit; end

  def create
    respond_with(@question = Question.create(question_params))
  end

  def update
    @question.update(question_params)
    respond_with(@question)
  end

  def destroy
    respond_with(@question.destroy)
  end

  private

  def load_question
    @question = Question.find_by(id: params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, :owner_id, attachments_attributes: %i[id file attacher_id _destroy])
  end
end
