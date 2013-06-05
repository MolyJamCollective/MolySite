class Sponsor < ActiveRecord::Base
  attr_accessible :event_id, :order, :image, :url
  has_attached_file :image
end
