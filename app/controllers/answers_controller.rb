class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_answer, only: %w[show edit update destroy]

  def index
    @answers = Answer.all
  end

  def show; end

  def new
    @answer = Answer.new
  end

  def edit; end

  def create
    @answer = Answer.new(answer_params)

    if @answer.save
      redirect_to questions_path
    else
      @question = Question.find_by(id: params[:answer][:question_id])
      redirect_to @question
    end
  end

  def update
    if @answer.update(answer_params)
      redirect_to @answer
    else
      render :edit
    end
  end

  def destroy
    @answer.destroy
    redirect_to answers_path
  end

  private

  def load_answer
    @answer = Answer.find_by(id: params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, :question_id)
  end
end
