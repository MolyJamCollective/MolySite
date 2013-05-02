class Venue < ActiveRecord::Base
  belongs_to :event
  belongs_to :group

  attr_accessible :address, :description, :latitude, :longitude, :name, :event_id, :group_id
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?

  after_create :create_group

  def create_group
    self.group_id = Group.create(name: self.name, description: self.description).id
    self.save
    true
  end
end
