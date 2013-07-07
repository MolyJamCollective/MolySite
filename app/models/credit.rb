class Credit < ActiveRecord::Base
  belongs_to :game
  belongs_to :user
  
  attr_accessible :game_id, :title, :user_id
end
