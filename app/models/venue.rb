class Venue < ActiveRecord::Base
  belongs_to :event
  belongs_to :group

  attr_accessible :address, :description, :description_raw, :latitude, :longitude, :name, :event_id, :group_id
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
    user.groups << self.group
    user.groups << self.event.group
    if host
      user.groups << Group.where(name: "Hosts")
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
