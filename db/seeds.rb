# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Groups
Group.create!(name: "Webmasters")
Group.create!(name: "Organizers")
Group.create!(name: "Hosts")
Group.create!(name: "Jammers")
Group.create!(name: "Users")

if(Rails.env == "development")

  # Users
  User.create!(email: "webmaster@email.com", password: "password").confirm!
  User.create!(email: "organizer@email.com", password: "password").confirm!
  User.create!(email: "host@email.com", password: "password").confirm!
  User.create!(email: "jammer@email.com", password: "password").confirm!
  User.create!(email: "user@email.com", password: "password").confirm!

  # Memberships
  Membership.create!(user_id: 1, group_id: 1) # webmaster.groups << webmasters
  Membership.create!(user_id: 2, group_id: 2) # organizer.groups << organizers
  Membership.create!(user_id: 3, group_id: 3) # host.groups << hosts
  Membership.create!(user_id: 4, group_id: 4) # jammer.groups << jammers
  Membership.create!(user_id: 5, group_id: 5) # user.groups << users

  # Events
  Event.create!(name: "Event", description: "Description", start_date: DateTime.current() , end_date: DateTime.current(), published: true)

  # Venues
  Venue.create!(name: "New York", address: "New York, New York", description: "Description", event_id: 1)
  Venue.create!(name: "Orlando", address: "Orlando, FL", description: "Description", event_id: 1)

end