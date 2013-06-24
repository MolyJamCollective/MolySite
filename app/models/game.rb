class Game < ActiveRecord::Base
  attr_accessible :event_id, :group_id, :inspiration, :name, :venue_id
end
