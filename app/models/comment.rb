class Comment < ApplicationRecord
  include CommentsControllerHelper

  belongs_to :commenter, foreign_key: 'commenter_id', class_name: 'User', touch: true

  validates :text, presence: true

  private

  def publish_data_runtime(object, type, css_class)
    ActionCable.server.broadcast(
      'comments',
      class:   css_class,
      message: ApplicationController.render(
        partial: 'comments/comments',
        locals:  { object: object, type: type, current_user: commenter }
      )
    )
  end
end
