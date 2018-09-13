class Attachment < ApplicationRecord
  mount_uploader :file, AttachmentUploader
end
