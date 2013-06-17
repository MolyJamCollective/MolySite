class Venue < ActiveRecord::Base
  belongs_to :event
  belongs_to :group
  has_many :sponsors

  attr_accessible :street, :state, :country, :city, :region, :url, :contact, :description,
    :description_raw, :latitude, :longitude, :name, :event_id, :group_id, :twitch_username, :display_name, :approved
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
  after_validation :process_markdown, :if => :description_raw_changed?

  after_create :create_group

  REGIONS = ["Australia", "North America", "South America", "Europe", "Asia"]

  def email
    "#{self.display_name.gsub(/\s+/, "")}@MolyJam.com"
  end

  def address
    address = ""
    address << self.street
    address << ', ' unless address.empty? || address[-2, 2] == ', '
    address << (self.city.empty? ? self.display_name : self.city)
    address << ', ' unless address.empty? || address[-2, 2] == ', '
    address << self.state
    address << ', ' unless address.empty? || address[-2, 2] == ', '
    address << self.country_name
  end

  def address_street
    self.street
  end

  def address_city_state_zip
    address = ""
    address << (self.city.empty? ? self.display_name : self.city)
    address << ', ' unless address.empty? || address[-2, 2] == ', '
    address << self.state
    address << ', ' unless address.empty? || address[-2, 2] == ', '
    address << self.country_name
  end

  def address_changed?
    self.street_changed? && self.city_changed? && self.state_changed? && self.country_changed?
  end

  def create_group
    self.group_id = Group.create(name: self.name, description: self.description).id
    self.save
    true
  end

  def country_name
    Carmen::Country.coded(self.country).name
  end

  def has_eventbrite?
    return url.nil? == false && url.match(/eventbrite\.com.*eid/).nil? == false
  end

  # Returns a facebook or eventbrite id based on the url attribute
  def remote_event_id
    if(has_eventbrite?)
      remote_params = CGI::parse(url.split("?").last)
      return remote_params["eid"].first
    end
    return nil
  end

  def hosts
    host_list = Array.new

    self.users.each do |user|
      host_list.push(user) if user.memberships.where(group_id: self.group_id).first.role >= Membership::ROLES[:officer]
    end
  end

  def users
    self.group.users
  end

  def register_user(user, host = false)
    Membership.set(user, self.event.group_id) unless self.event.nil? # Join Event

    if host
      if self.group.users.empty?
        Membership.set(user, self.group, :founder) # Join Venue as Founder
      else
        Membership.set(user, self.group, :officer) # Join Venue as Venue
      end
      Membership.set(user, Group.where(name: "Hosts").first)
    else
       Membership.set(user, self.group) # Join Venue
    end
  end

  def process_markdown
    require 'redcarpet'

    renderer = Redcarpet::Render::HTML.new(
      filter_html: true,
      safe_links_only: true,
      hard_wrap: true
      )
    extensions = {
      no_intra_emphasis: true,
      autolink: true,
      strikethrough: true,
      lax_spacing: true,
      superscript: true,
      underline: true
    }
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)

    self.description = redcarpet.render(self.description_raw)
  end

end
