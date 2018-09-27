class SubscribeNotificationsController < ApplicationController
  load_and_authorize_resource

  respond_to :js

  def create
    @subscribe_notification = SubscribeNotification.create(subscribe_notification_params)
    respond_with(@subscribe_notification)
  end

  def destroy
    subscribe_notification = SubscribeNotification.find(params[:id])
    @question = subscribe_notification.question
    respond_with(subscribe_notification.destroy)
  end

  private

  def subscribe_notification_params
    params.require(:subscribe_notification).permit(:question_id, :user_id)
  end
end
