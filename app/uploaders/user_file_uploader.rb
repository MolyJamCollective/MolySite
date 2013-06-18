require 'carrierwave/processing/mime_types'
class UserFileUploader < CarrierWave::Uploader::Base

  include CarrierWave::MimeTypes
  process :set_content_type

  include CarrierWaveDirect::Uploader
end
