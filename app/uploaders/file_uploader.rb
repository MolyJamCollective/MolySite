class FileUploader < CarrierWave::Uploader::Base
  include CarrierWaveDirect::Uploader

  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  include CarrierWave::MimeTypes
  process :set_content_type

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(zip tar gz)
  end

end
