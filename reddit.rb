require 'http'
puts "Please enter the name of a subreddit"
subreddit = gets.chomp
begin
  response = HTTP.get"https://www.reddit.com/r/#{subreddit}/.json"
  link = response.parse(:json)
  # pp link

  rescue
    puts "not a subreddit"
end

x = 2
25.times do
  puts "#{x-2}. #{link["data"]["children"][x]["data"]["title"]}"
  puts ""
  puts "#{link["data"]["children"][x]["data"]["media_embed"]["content"]}"
  x += 1
end
# prework 454 was where we learned rescue