require 'http'
require 'tty-prompt'
prompt = TTY::Prompt.new

puts "Please enter the name of a subreddit"
subreddit = gets.chomp
begin
  response = HTTP.get"https://www.reddit.com/r/#{subreddit}/.json"
  link = response.parse(:json)
  # rescues thrown error resulting from an url that doesn't lead to a subreddit
  rescue
    puts "not a subreddit"
end

# sends the first 15 posts to terminal
x = 2
15.times do
  puts "#{x-1}. #{link["data"]["children"][x]["data"]["title"]}"
  # this line only works with certain subreddits. Need to fix that
  if link["data"]["children"][x]["data"]["media_embed"]["content"] == nil
    puts "(post has no text)"
  else
    puts "#{link["data"]["children"][x]["data"]["media_embed"]["content"]}"
  end
  puts ""
  x += 1
end