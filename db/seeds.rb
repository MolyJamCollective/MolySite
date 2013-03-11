# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Groups
Group.new(name: "Webmasters").save
Group.new(name: "Organizers").save
Group.new(name: "Hosts").save
Group.new(name: "Jammers").save
Group.new(name: "Users").save

if(Rails.env == "development")
	User.new(email: "webmaster@email.com", password: "password").confirm!
	User.new(email: "organizer@email.com", password: "password").confirm!
	User.new(email: "host@email.com", password: "password").confirm!
	User.new(email: "jammer@email.com", password: "password").confirm!
	User.new(email: "user@email.com", password: "password").confirm!
end