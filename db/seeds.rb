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

  Venue.create!(display_name: "Los Angeles",  name: "Name", street: "1212 Washington Blvd",         city: "Los Angeles",  state: "California",  country: "US", region: "North America",  description_raw: description_raw, approved: true,   event_id: 1)
  Venue.create!(display_name: "New York",     name: "Name", street: "481 Broadway",                 city: "New York",     state: "New York",    country: "US", region: "North America",  description_raw: description_raw, approved: true,   event_id: 1)
  Venue.create!(display_name: "Paris",        name: "Name", street: "70 Avenue des Champs Elysees", city: "Paris",        state: "",            country: "FR", region: "Europe",         description_raw: description_raw, approved: true,   event_id: 1)
  Venue.create!(display_name: "Adelaide",     name: "Name", street: "Strangways Terrace",           city: "Adelaide",     state: "",            country: "AU", region: "Australia",      description_raw: description_raw, approved: false,  event_id: 1)

  Venue.find(1).register_user(User.find(3), true)

  #fake file upload for webmaster
  UserFileUpload.create!(user_id: 1, file_size: 30, file_path: "http://www.google.com/1.jpg")

end

Inspiration.create!(quote: "When you rip your fingers on the screen and you tear the landscape apart with your physical hands, it just feels amazing, man. It feels amazing.", source: "http://www.rockpapershotgun.com/2012/11/22/interview-peter-molyneux-on-curiositys-failings-godus/")
Inspiration.create!(quote: "When you're doing it in multiplayer, it feels incredible. I love that.", source: "http://www.rockpapershotgun.com/2012/11/22/interview-peter-molyneux-on-curiositys-failings-godus/")
Inspiration.create!(quote: "The touch, the grab, the stroke, all of those things we're going to be obsessed about.", source: "http://www.rockpapershotgun.com/2012/11/22/interview-peter-molyneux-on-curiositys-failings-godus/")
Inspiration.create!(quote: "I wish I had some time machine and could go back two weeks. You live by your mistakes, for sure.", source: "http://www.rockpapershotgun.com/2012/11/22/interview-peter-molyneux-on-curiositys-failings-godus/")
Inspiration.create!(quote: "You sneak that little thing in there at the end.", source: "http://www.eurogamer.net/articles/2012-04-11-peter-molyneux-why-i-quit-microsoft-and-why-my-new-game-will-change-the-world")

Inspiration.create!(quote: "The most powerful story I could possibly tell is a story that reminds you of your own childhood. We've all had times in our childhood, common experiences when we felt down, and we felt up, or we celebrated doing something for the first time, and I loved that thought.", source: "http://www.vg247.com/2012/03/14/molyneux-games-industry-wasnt-ready-for-milos-concept/")
Inspiration.create!(quote: "I'm not punishing you for button mashing; I'm rewarding you for not button mashing, and that is a really big distinction.", source: "http://archive.videogamesdaily.com/news/200708/015_p1.asp")
Inspiration.create!(quote: "You can actually break someone's neck on some railing during combat. It could be a spike on a fence or a solid brick wall, and you'll get increased experience for that as well.", source: "http://archive.videogamesdaily.com/news/200708/015_p1.asp")
Inspiration.create!(quote: "I want you to think of the sword as a conductor's baton. As you're fighting, we'll be introducing different musical elements, the more successful you are. And we'll be upping the tempo of the music, the more abilities that you unlock. So you not only get more of a score, you get a cooler soundtrack.", source: "http://archive.videogamesdaily.com/news/200708/015_p1.asp")
Inspiration.create!(quote: "The whole of your body, except for your private parts, can be scarred. You are clothed most of the time, but not in front of your wife, and not when you swim, either. Don't forget: it's the emotion of being scarred.", source: "http://archive.videogamesdaily.com/news/200708/015_p2.asp")

Inspiration.create!(quote: "Freedom is... freedom can actually be boring, you've got to realize that.", source: "http://archive.videogamesdaily.com/features/petermolyneux_iv_jun06_p2.asp")
Inspiration.create!(quote: "Some people leave artwork, some people do rude things, other people then turn those rude things into nice things.", source: "http://www.gamasutra.com/view/news/181114/Noct_even_Apple_knows_whats_inside_Curiositys_cube.php")
Inspiration.create!(quote: "I keep finding myself rejected by men, which is a new experience for me.", source: "http://www.gamasutra.com/php-bin/news_index.php?story=17609")
Inspiration.create!(quote: "Pull the right trigger to see The Most Interesting Thing in the World.", source: "http://www.gamasutra.com/php-bin/news_index.php?story=17609")
Inspiration.create!(quote: "Will the first female nudity give you a success or will it turn off the audience?", source: "http://www.giantbomb.com/peter-molyneux/3040-3890/")

Inspiration.create!(quote: "You know what this industry's like: As soon as there is the scent of death, everyone jumps on the hearse.", source: "http://beefjack.com/opinion/peter-molyneux-the-unstoppable-quote-machine/")
Inspiration.create!(quote: "I still have nightmares about holding German sausages over my head.", source: "http://www.ign.com/articles/2011/03/17/peter-molyneux-the-man-behind-the-mask")
Inspiration.create!(quote: "If you love your dog, we're gonna mess with your mind, man. You're not going to be able to go to bed.", source: "http://www.escapistmagazine.com/news/view/69427-GDC-2007-Peter-Molyneux")
Inspiration.create!(quote: "You can eliminate starvation or you can double it, you can empty the treasury or fill it with gold and rub it all over your body.", source: "http://www.bit-tech.net/gaming/xbox-360/2010/03/23/peter-molyneux-fable-3-and-emotional-games/2")
Inspiration.create!(quote: "Part of the fun of dogs is they misbehave and can be enormously embarrassing to the owner.", source: "http://www.bit-tech.net/gaming/xbox-360/2010/03/23/peter-molyneux-fable-3-and-emotional-games/2")

Inspiration.create!(quote: "I have to be careful what I say. There are PR policeman in the audience with sniper rifles.", source:"http://www.bit-tech.net/gaming/xbox-360/2010/03/23/peter-molyneux-fable-3-and-emotional-games/3")
Inspiration.create!(quote: "The touch, the grab, the stroke: All of those things we're going to be obsessed about.", source: "http://www.rockpapershotgun.com/2012/11/22/interview-peter-molyneux-on-curiositys-failings-godus/")
Inspiration.create!(quote: "I wish I had some time machine and could go back two weeks. You live by your mistakes, for sure.", source: "http://www.rockpapershotgun.com/2012/11/22/interview-peter-molyneux-on-curiositys-failings-godus/")
Inspiration.create!(quote: "I could be alone in a pub drinking a pint of bitter. Come along!", source: "http://www.eurogamer.net/articles/2012-04-11-peter-molyneux-why-i-quit-microsoft-and-why-my-new-game-will-change-the-world")
Inspiration.create!(quote: "The whole of your body, except for your private parts, can be scarred. You are clothed most of the time, but not in front of your wife, and not when you swim, either. Don't forget: It's the emotion of being scarred.", source: "http://archive.videogamesdaily.com/news/200708/015_p2.asp")

Inspiration.create!(quote: "Some people leave artwork, some people do rude things, other people then turn those rude things into nice things.", source: "http://www.gamasutra.com/view/news/181114/Noct_even_Apple_knows_whats_inside_Curiositys_cube.php")
Inspiration.create!(quote: "The engine isn't finished. Her buttocks are wrong.", source: "http://www.gamasutra.com/php-bin/news_index.php?story=17609")
Inspiration.create!(quote: "It's you Americans. There's something about nipples you hate. If this were Germany, we'd be romping around naked on the stage here.", source: "http://www.gamasutra.com/php-bin/news_index.php?story=17609")
Inspiration.create!(quote: "You and your girlfriend will enjoy this like you've never enjoyed anything else in your life.", source: "http://www.gamasutra.com/view/feature/132402/peter_molyneux_the_essence_of_.php?page=4")
Inspiration.create!(quote: "His purpose in life-like Asimov's laws of robotics-is not to aggravate you, not to piss you off. His second thought is this: He absolutely loves you.", source: "http://www.escapistmagazine.com/news/view/69427-GDC-2007-Peter-Molyneux")

Inspiration.create!(quote: "Part of the fun of dogs is they misbehave and can be enormously embarrassing to the owner.", source: "http://www.bit-tech.net/gaming/xbox-360/2010/03/23/peter-molyneux-fable-3-and-emotional-games/2")
