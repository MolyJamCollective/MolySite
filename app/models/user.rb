class User < ActiveRecord::Base
  include Gravtastic
  gravtastic
  
	has_many :memberships
	has_many :groups, :through => :memberships

  	# Include default devise modules. Others available are:
  	# :omniauthable
  	devise 	:database_authenticatable, :registerable,
  			:recoverable, :rememberable, :trackable, :validatable,
  			:token_authenticatable, :confirmable, :lockable, :timeoutable

  	# Setup accessible (or protected) attributes for your model
  	attr_accessible :email, :password, :password_confirmation, :remember_me
  	attr_accessible :username, :name, :biography, :location, :website, :twitter_username

  def group?(group)
    self.groups.exists?(name: group.to_s)
  end

  before_update :revert_username_if_changed, :if => Proc.new { |u| u.username_changed? }

  def revert_username_if_changed
    self.username = self.username_was
  end
end
