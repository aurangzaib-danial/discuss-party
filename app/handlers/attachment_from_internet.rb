class AttachmentFromInternet < Struct.new(:url, :file)
  def self.for_active_storage(image_url)
    object = self.from_url(image_url)
    {io: object.file, filename: object.filename}
  end

  def self.from_url(url)
    self.new(url).tap {|o| o.download_file }
  end

  def download_file
    self.file = Down.download(url)
  end

  def filename
    file.original_filename
  end
end
