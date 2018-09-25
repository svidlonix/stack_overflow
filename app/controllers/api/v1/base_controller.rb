module Api
  module V1
    class BaseController < ApplicationController
      respond_to :json
      before_action :doorkeeper_authorize!

      protected

      def current_resource_owner(id)
        User.find(id) if doorkeeper_token
      end

      def current_user
        User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
      end
    end
  end
end
