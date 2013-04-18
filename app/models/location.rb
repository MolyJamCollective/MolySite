class Location < ActiveRecord::Base
  attr_accessible :address, :description, :latitude, :longitude, :name
end
