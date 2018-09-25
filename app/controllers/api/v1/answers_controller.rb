module Api
  module V1
    class AnswersController < Api::V1::BaseController
      load_and_authorize_resource

      def index
        @answers = Question.find_by(id: params[:question_id]).answers
        respond_with(@answers)
      end

      def show
        respond_with(@answer)
      end

      def create
        respond_with(@answer = Answer.create(answer_params))
      end

      private

      def answer_params
        params.require(:answer).permit(:body, :question_id, :owner_id)
      end
    end
  end
end
