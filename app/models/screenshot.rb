class Screenshot < ActiveRecord::Base
  attr_accessible :game_id, :image
  belongs_to :game
  mount_uploader :image, ScreenshotUploader
end
