require "koala"
require "optparse"
require "time"

optparse = OptionParser.new do |opts|
   opts.banner = "Usage: facebot.rb [options]"
   opts.on('-t', '--token STRING', 'The Oauth Token with which to connect') do |token|
      @token = token
   end
   opts.on('-h', '--help', 'Prints this help screen') do
      puts opts
      exit
   end
end
optparse.parse!

# get a handle for the graph api
@graph = Koala::Facebook::GraphAPI.new(@token)

@friends = nil #poor man's memoization
def get_friends()
   return @friends unless @friends.nil?
   @friends = @graph.get_object("me/friends")["data"].map do |friend| 
      @graph.get_object(friend["id"])
   end
   return @friends
end

def get_todays_birthdays() #returns a list of friends who's birthdays are today
   friends = get_friends

   friends.select do |friend|
      birthday = friend["birthday"]
      next if birthday.nil?
      case birthday.count("/")
      when 1
         parsed_birthday = Time.strptime(birthday, "%m/%d")
	 parsed_birthday.day == Time.now.day and parsed_birthday.month == Time.now.month 
      when 2
         parsed_birthday = Time.strptime(birthday, "%m/%d/%Y")
	 parsed_birthday.day == Time.now.day and parsed_birthday.month == Time.now.month 
      end
   end
end

def wish_happy_birthday() #wish each friend happy birthday
   get_todays_birthdays.each do |friend|
      @graph.put_wall_post("Happy Birthday!", {}, friend["id"])
   end
end

wish_happy_birthday
