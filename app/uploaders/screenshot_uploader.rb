class ScreenshotUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  include CarrierWave::MimeTypes
  process :set_content_type

  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb_grid do
    process resize_to_limit: [320, 320]
  end

  version :thumb_article do
    process resize_to_limit: [600, 600]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
