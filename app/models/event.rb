class Event < ActiveRecord::Base
  belongs_to :group
  has_many :venues

  after_create :create_group

  attr_accessible :end_date, :start_date, :name, :description

  def create_group
    self.group_id = Group.create(name: self.name, description: self.description).id
    self.save
    true
  end
end