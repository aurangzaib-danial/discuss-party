class UserAttachmentJob < ApplicationJob
  queue_as :default

  def perform(user, image_url)
    file = Down.download(image_url)
    user.display_picture.attach(io: file, filename: file.original_filename)
  end
end
