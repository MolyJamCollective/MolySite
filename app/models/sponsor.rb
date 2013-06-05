class Sponsor < ActiveRecord::Base
  belongs_to :venue

  attr_accessible :venue_id, :rank, :image, :url
  has_attached_file :image

  before_save :sort

  def sort
    if self.rank.nil?
      last = Sponsor.where(venue_id: self.venue_id).order(rank: "ASC").last
      unless last.nil?
      	self.rank = last.rank + 1
      else
        self.rank = 0
      end
    end
    #TODO: Handle Collisions on Rank
  end

  def move_up
    next_sponsor = Sponsor.where("venue_id = ? AND rank < ?", self.venue_id, self.rank).order(rank: "ASC").last
    Sponsor.decrement_counter(:rank, self.id)
    Sponsor.increment_counter(:rank, next_sponsor.id) unless next_sponsor.nil?
  end

  def move_down
    prev_sponsor = Sponsor.where("venue_id = ? AND rank > ?", self.venue_id, self.rank).order(rank: "ASC").last
    Sponsor.decrement_counter(:rank, prev_sponsor.id) unless prev_sponsor.nil?
    Sponsor.increment_counter(:rank, self.id)
  end
end
