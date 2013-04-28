class User < ActiveRecord::Base
	has_many :memberships
	has_many :groups, :through => :memberships

  	# Include default devise modules. Others available are:
  	# :omniauthable
  	devise 	:database_authenticatable, :registerable,
  			:recoverable, :rememberable, :trackable, :validatable,
  			:token_authenticatable, :confirmable, :lockable, :timeoutable

  	# Setup accessible (or protected) attributes for your model
  	attr_accessible :email, :password, :password_confirmation, :remember_me
  	# attr_accessible :title, :body

  	attr_accessible :name, :biography, :location, :website

  def group?(group)
    self.groups.exists?(name: group.to_s)
  end
end
