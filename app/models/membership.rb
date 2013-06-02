class Membership < ActiveRecord::Base
	belongs_to :user
	belongs_to :group

  attr_accessible :group_id, :role, :user_id

  ROLES = { founder: 90, officer: 60, member: 30, }

  after_initialize do
  	self.role = ROLES[:member] unless self.role
  end

  def self.set(user, group, role = nil)
    group_id = group if group.is_a?(Numeric)
    group_id = group.id if group.instance_of?(Group)

    user_id = user if user.is_a?(Numeric)
    user_id = user.id if user.instance_of?(User)

    role_value = role if role.is_a?(Numeric)
    role_value = ROLES[role.to_sym] if role.instance_of?(String)
    role_value = ROLES[role] if role.instance_of?(Symbol)
    role_value = ROLES[:member] if role_value.nil?

    membership = Membership.where(user_id: user_id, group_id: group_id).first
    if(membership.nil?)
      Membership.create!(user_id: user_id, group_id: group_id, role: role_value)
    else
      membership.role = role_value
      membership.save
    end

  end

  before_save do
  	old_membership = Membership.where(user_id: self.user_id, group_id: self.group_id).first
  	unless old_membership.nil? || old_membership.id == self.id
  		raise "Tried to create duplicate membership" 
  		false
  	end
  end
end
