class Game < ActiveRecord::Base
  belongs_to :event
  belongs_to :venue
  belongs_to :group
  has_many :users, :through => :group

  attr_accessible :event_id, :group_id, :inspiration, :name, :venue_id, :description, :directions

  after_create :create_group

  def create_group
    self.group_id = Group.create(name: self.name).id
    self.save
    true
  end
end