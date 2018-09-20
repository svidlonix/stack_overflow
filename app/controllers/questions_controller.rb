class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question, only: %w[show edit update destroy]
  after_action :publish_data_runtime, only: %w[create update destroy]

  def index
    all_questions
  end

  def show; end

  def new
    @question = Question.new
    @attachments = @question.attachments.build
  end

  def edit; end

  def create
    @question = Question.new(question_params)

    if @question.save
      publish_data_runtime
      redirect_to @question
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path
  end

  private

  def all_questions
    @questions = Question.all
  end

  def load_question
    @question = Question.find_by(id: params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, :owner_id, attachments_attributes: %i[id file attacher_id _destroy])
  end

  def publish_data_runtime
    ActionCable.server.broadcast(
      'questions',
      ApplicationController.render(
        partial: 'questions/questions_list',
        locals:  {questions: all_questions}
      )
    )
  end
end
