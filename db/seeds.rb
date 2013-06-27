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
  User.create!(username: "webmaster", name: "Webmaster", email: "webmaster@email.com", password: "password", twitter_username: "webmaster").confirm!
  User.create!(username: "organizer", name: "Organizer", email: "organizer@email.com", password: "password", twitter_username: "organizer").confirm!
  User.create!(username: "host",      name: "Host",      email: "host@email.com", password: "password", twitter_username: "host").confirm!
  User.create!(username: "jammer",    name: "Jammer",    email: "jammer@email.com", password: "password", twitter_username: "jammer").confirm!
  User.create!(username: "user",      name: "User",      email: "user@email.com", password: "password", twitter_username: "user").confirm!

  # Memberships
  Membership.create!(user_id: 1, group_id: 1) # webmaster.groups << webmasters
  Membership.create!(user_id: 2, group_id: 2) # organizer.groups << organizers
  Membership.create!(user_id: 3, group_id: 3) # host.groups << hosts
  Membership.create!(user_id: 4, group_id: 4) # jammer.groups << jammers

  # Events
  Event.create!(name: "Molyjam 2013", description: "Description", start_date: DateTime.current() , end_date: DateTime.current())

  # Venues
  description_raw = "
###Parking / Transportation###
There are multiple public parking garages available around Culver City. The one on Cardiff Ave is closest to the jam site, and is open until 3 AM every night. There is a maximum charge of $8 per day. The jam site is also just a few blocks from the Expo Line.
***
###Food / Drinks###
Snacks and drinks will be provided. Alcohol is permitted. There are a ton of restaurants within walking distance, such as Tender Greens, Daphne's, and Chipotle.
***
###Technology###
No computers are provided at this site. Bring your own laptop or desktop - there will be fast wireless internet access, and limited ethernet connections. Bring a power strip if you plan on having lots of things plugged in. There are also a couple conference rooms and whiteboards you can use for breakout sessions.
***
###Building Access###
This jam site will be open 24 hours. It'll be open when you arrive - come upstairs. Starting at 9 PM, the doors will be locked but there will be a number you can call to get back in. 24 hour-access does not mean you should sleep here, and you're encouraged to go home.
***
###Press & Media###
Members of the press are welcome to attend this jam. Contact Holden Link at losangeles@molyjam.com if you plan to bring any recording equipment that may need setup time or space.
"

  Venue.create!(display_name: "Los Angeles",  name: "Name", street: "1212 Washington Blvd",         city: "Los Angeles",  state: "California",  country: "US", region: "North America",  description_raw: description_raw, approved: true,   event_id: 1, url: "")
  Venue.create!(display_name: "New York",     name: "Name", street: "481 Broadway",                 city: "New York",     state: "New York",    country: "US", region: "North America",  description_raw: description_raw, approved: true,   event_id: 1, url: "")
  Venue.create!(display_name: "Paris",        name: "Name", street: "70 Avenue des Champs Elysees", city: "Paris",        state: "",            country: "FR", region: "Europe",         description_raw: description_raw, approved: true,   event_id: 1, url: "")
  Venue.create!(display_name: "Adelaide",     name: "Name", street: "Strangways Terrace",           city: "Adelaide",     state: "",            country: "AU", region: "Australia",      description_raw: description_raw, approved: false,  event_id: 1, url: "")

  Venue.find(1).register_user(User.find(3), true)

  #fake file upload for webmaster
  UserFileUpload.create!(user_id: 1, file_size: 30, file_path: "http://www.google.com/1.jpg")

  Inspiration.create!(quote: "When you rip your fingers on the screen and you tear the landscape apart with your physical hands, it just feels amazing, man. It feels amazing.", source: "http://www.rockpapershotgun.com/2012/11/22/interview-peter-molyneux-on-curiositys-failings-godus/")
  Inspiration.create!(quote: "When you're doing it in multiplayer, it feels incredible. I love that.", source: "http://www.rockpapershotgun.com/2012/11/22/interview-peter-molyneux-on-curiositys-failings-godus/")
  Inspiration.create!(quote: "The touch, the grab, the stroke, all of those things we're going to be obsessed about.", source: "http://www.rockpapershotgun.com/2012/11/22/interview-peter-molyneux-on-curiositys-failings-godus/")
  Inspiration.create!(quote: "I wish I had some time machine and could go back two weeks. You live by your mistakes, for sure.", source: "http://www.rockpapershotgun.com/2012/11/22/interview-peter-molyneux-on-curiositys-failings-godus/")
  Inspiration.create!(quote: "You sneak that little thing in there at the end.", source: "http://www.eurogamer.net/articles/2012-04-11-peter-molyneux-why-i-quit-microsoft-and-why-my-new-game-will-change-the-world")
end

