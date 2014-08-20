puts "\n\n\n\nWelcome to the Memory Game!!!\n\n\n\n"
topic = ""

sleep(1)

# load the topic list
topic_name_list = Hash.new
topic_name_list["states"] = "us_states.txt"
topic_name_list["ttc stations"] = "ttc_stations.txt"
topic_name_list["nhl teams"] = "nhl_teams.txt"
topic_name_list["european countries"] = "european_countries.txt"

# user selects a topic...make sure it's in the list
begin
	puts "Please enter a topic...\n\n"
	STDOUT.flush
	topic = gets.chomp
	if !topic_name_list.include? topic
		puts "\nInvalid topic. Consider trying '#{topic_name_list.keys.sample}'\n\n"
	else
		puts "\nExcellent choice.\n\n\n\n"
		break
	end
end while true

# load answer file
answers = Array.new
correct_answers = Array.new
answer_file = File.open(topic_name_list[topic]) or die "Unable to find answer file for topic #{topic}"
answer_file.each_line {|line|
	answers.push line.chomp.upcase
}

puts "Ok, time to start listing #{topic}\n"

begin
	puts "#{answers.count} #{topic} remaining...\n\n"
	STDOUT.flush
	attempt = gets.chomp.upcase
	
	if attempt == "EXIT" then break end
	if attempt == "DEBUG" then puts answers end
	if attempt == "HINT" 
		puts "\n\nClue: starts with '#{answers.sample[0]}'\n\n" 
	else
		if answers.include? attempt
			correct_answers.push attempt
			answers.delete(attempt)
			if answers.count == 0
				puts "\n\nCongratulations! You named all #{correct_answers.count} #{topic}!\n\n\n\n"
				break
			else
				puts "\nYou got one! Good job!\n\n"
			end
		else
			if correct_answers.include? attempt
				puts "\nYou already named that one!\n\n"
			else
				puts "\nNice try, but that's not one of the #{topic}\n\n"
			end
		end
	end
end while true