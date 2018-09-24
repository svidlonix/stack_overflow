class QuestionsController < ApplicationController
  before_action :authenticate_user!

  load_and_authorize_resource

  def index; end

  def show; end

  def new; end

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

  def question_params
    params.require(:question).permit(:title, :body, :owner_id, attachments_attributes: %i[id file attacher_id _destroy])
  end
end
