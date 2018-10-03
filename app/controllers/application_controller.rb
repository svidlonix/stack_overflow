require 'application_responder'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  self.responder = ApplicationResponder
  respond_to :html

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to(root_url, alert: exception.message)
  end
end
