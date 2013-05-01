class Venue < ActiveRecord::Base
  belongs_to :event

  attr_accessible :address, :description, :latitude, :longitude, :name, :event_id
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
end
