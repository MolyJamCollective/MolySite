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
  User.create!(email: "webmaster@email.com", password: "password", twitter_username: "webmaster").confirm!
  User.create!(email: "organizer@email.com", password: "password", twitter_username: "organizer").confirm!
  User.create!(email: "host@email.com", password: "password", twitter_username: "host").confirm!
  User.create!(email: "jammer@email.com", password: "password", twitter_username: "jammer").confirm!
  User.create!(email: "user@email.com", password: "password", twitter_username: "user").confirm!

  # Memberships
  Membership.create!(user_id: 1, group_id: 1) # webmaster.groups << webmasters
  Membership.create!(user_id: 2, group_id: 2) # organizer.groups << organizers
  Membership.create!(user_id: 3, group_id: 3) # host.groups << hosts
  Membership.create!(user_id: 4, group_id: 4) # jammer.groups << jammers
  Membership.create!(user_id: 5, group_id: 5) # user.groups << users

  # Events
  Event.create!(name: "Molyjam 2013", description: "Description", start_date: DateTime.current() , end_date: DateTime.current(), published: true)

  # Venues
  description_raw = "### Description ###"

  Venue.create!(region: "North America", city: "New York", country: "us", name: "Babycastles", address: "481 Broadway, New York, NY", contact: "George Washington", description_raw: description_raw, event_id: 1)
  Venue.create!(region: "North America", city: "Los Angeles", country: "us", name: "NextSpace", address: "1212 Washington Blvd, Culver City, CA", contact: "Theodore Roosevelt", description_raw: description_raw, event_id: 1)
  Venue.create!(region: "Europe", city: "Paris", country: "fr", name: "SomeVenueName", address: "70 Avenue des Champs Elysees, Paris, France", contact: "John Adams", description_raw: description_raw, event_id: 1)
  Venue.create!(region: "Australia", city: "Adelaide", country: "au", name: "OzVenue", address: "Strangways Terrace North Adelaide SA 5006, Australia", contact: "Benjamin Franklin", description_raw: description_raw, event_id: 1)

  Venue.find(1).register_user(User.find(3), true)

end