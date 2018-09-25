module Api
  module V1
    class Api::V1::QuestionsController < Api::V1::BaseController
      load_and_authorize_resource

      def index
        respond_with(@questions)
      end

      def show
        respond_with(@question)
      end

      def create
        respond_with(@question = Question.create(question_params))
      end

      private

      def question_params
        params.require(:question).permit(:title, :body, :owner_id)
      end
    end
  end
end
