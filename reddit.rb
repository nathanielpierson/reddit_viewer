require 'http'
require 'tty-prompt'
prompt = TTY::Prompt.new

puts "Please enter the name of a subreddit"
subreddit = gets.chomp 
running = true
begin
  response = HTTP.get"https://www.reddit.com/r/#{subreddit}/.json"
  link = response.parse(:json)
  # rescues thrown error resulting from an url that doesn't lead to a subreddit and prevents rest of code from running
  rescue
    puts "not a subreddit"
    running = false
end

# asks user if they want 5, 10, or 15 posts and prints out that many to the terminal

if running == true
  lines = prompt.select("how many results would you like to see?", %w(5 10 15))
  x = 2
  lines.to_i.times do
    puts "#{x-1}. #{link["data"]["children"][x]["data"]["title"]}"
    # helpful text to tell user if the content of the post is nil, otherwise prints the content
    if link["data"]["children"][x]["data"]["media_embed"]["content"] == nil
      puts "(post has no text)"
    else
      puts ""
      puts "#{link["data"]["children"][x]["data"]["media_embed"]["content"]}"
    end
    puts ""
    x += 1
  end
end