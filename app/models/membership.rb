class Membership < ActiveRecord::Base
	belongs_to :user
	belongs_to :group
  	attr_accessible :group_id, :role, :user_id

  	ROLES = { founder: 90, officer: 60, member: 30, }
end
