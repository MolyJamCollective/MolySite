class Game < ActiveRecord::Base
  belongs_to :event
  belongs_to :venue
  belongs_to :group
  has_many :users, :through => :group
  has_many :screenshots, dependent: :destroy
  has_many :credits, dependent: :destroy

  attr_accessible :event_id, :group_id, :inspiration, :name, :venue_id, :description, :directions, :play_in_browser_url,
   :play_in_browser_type, :android_url, :ios_url, :genre, :engine, :windows_file, :mac_file, :linux_file, :traditional_file

  mount_uploader :windows_file, FileUploader
  mount_uploader :mac_file, FileUploader
  mount_uploader :linux_file, FileUploader
  mount_uploader :traditional_file, FileUploader

  after_create :create_group

  def create_group
    self.group_id = Group.create(name: self.name).id
    self.save
    true
  end

  def add_user(user, role = :member)
    Membership.set(user.id, self.group_id, role)
    Membership.set(user.id, Group.where(name: "Jammers").first)
  end
  
end
