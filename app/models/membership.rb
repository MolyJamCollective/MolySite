class Membership < ActiveRecord::Base
	belongs_to :user
	belongs_to :group

  attr_accessible :group_id, :role, :user_id

  ROLES = { founder: 90, officer: 60, member: 30, }

  after_initialize do
  	self.role = ROLES[:member] unless self.role
  end

  before_save do
  	old_membership = Membership.where(user_id: self.user_id, group_id: self.group_id).first
  	unless old_membership.nil?
  		#raise "Tried to create duplicate membership" 
  		false
  	end
  end
end
