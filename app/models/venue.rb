class Venue < ActiveRecord::Base
  belongs_to :event
  belongs_to :group

  attr_accessible :address, :country, :city, :region, :contact, :description, :description_raw, :latitude, :longitude, :name, :event_id, :group_id
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
  after_validation :process_markdown, :if => :description_raw_changed?

  after_create :create_group

  def create_group
    self.group_id = Group.create(name: self.name, description: self.description).id
    self.save
    true
  end

  def register_user(user, host = false)
    membership = Membership.new(user_id: user.id, group_id: self.group.id)
    
    if host

      if self.group.users.empty?
        membership.role = Membership::ROLES[:founder]
      else
        membership.role = Membership::ROLES[:officer]
      end

      Membership.create!(user_id: user.id, group_id: Group.where(name: "Hosts").first.id)
    end
    membership.save

    Membership.create!(user_id: user.id, group_id: self.event.group.id)
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
