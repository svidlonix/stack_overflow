module Api
  module V1
    class AuthenticateController < Api::V1::BaseController
      def profile
        respond_with(current_resource_owner(doorkeeper_token.resource_owner_id))
      end

      def application_profiles
        users = []
        doorkeeper_token.application.access_tokens.each do |access_token|
          users << current_resource_owner(access_token.resource_owner_id)
        end

        respond_with(users)
      end
    end
  end
end
