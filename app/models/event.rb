class Event < ActiveRecord::Base
  attr_accessible :description, :end_date, :name, :published, :start_date
end
