class User < ActiveRecord::Base
  include Gravtastic
  gravtastic

  validates :username, :uniqueness => true
  after_create :add_to_user_group
  
	has_many :memberships
	has_many :groups, :through => :memberships

  	# Include default devise modules. Others available are:
  	# :omniauthable
  	devise 	:database_authenticatable, :registerable,
  		:recoverable, :rememberable, :trackable, :validatable,
  		:token_authenticatable, :confirmable, :lockable, :timeoutable,
      :authentication_keys => [:login]

  	# Setup accessible (or protected) attributes for your model
  	attr_accessible :email, :password, :password_confirmation, :remember_me,
      :username, :name, :biography, :location, :website, :twitter_username, :login

    attr_accessor :login

  def group?(group)
    self.groups.exists?(name: group.to_s)
  end

  def role
    return :Webmaster  if self.group? :Webmasters
    return :Organizer  if self.group? :Organizers
    return :Host       if self.group? :Hosts
    return :Jammer     if self.group? :Jammers
    return :User       if self.group? :Users
    :Undefined
  end

  def self.search(search)
    user = User.where(username: search).first
    return user unless user.nil?

    user = User.where(name: search).first
    return user unless user.nil?

    User.where(email: search).first
  end

  before_update :revert_username_if_changed, :if => Proc.new { |u| u.username_changed? }

  def revert_username_if_changed
    self.username = self.username_was
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def add_to_user_group
    Membership.create(user_id: self.id, group_id: Group.where(name: :Users).first.id);
  end
end
