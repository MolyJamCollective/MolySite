class Sponsor < ActiveRecord::Base
  belongs_to :venue

  attr_accessible :venue_id, :order, :image, :url
  has_attached_file :image
end
