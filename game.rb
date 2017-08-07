require "yaml"

class Game

	def initialize
	 @display_array = ('a'..'z').to_a
	 @selection_array =[]
	 @count
	end
#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><<><><><>
private	
	#creates directory if needed and saves hash contain game variables using yaml.
	def save_game
		Dir.mkdir('saved_games') unless File.exist?'saved_games'
		puts "please enter a name for your saved game."
		filename = gets.chomp + '.yaml'
		export = {:count => @count, :secret_word => @secret_word,:selection_array =>@selection_array,
			:blanks => @blanks}
		File.open(filename, 'w') do |f|
		f.puts YAML::dump(export)
		end
			
	end
	#loads in saved game reassigns variables from the yaml file.
	def load_game
		puts "please enter a name for your saved game."
		filename = gets.chomp + '.yaml'
		File.open(filename, 'r') do |f|
		x = YAML::load(f)
		@count = x[:count]
		@secret_word = x[:secret_word]
		@selection_array = x[:selection_array]
		@blanks = x[:blanks]
		end
	end
#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><<><><><>
	#loads in dictionary into array chooses a random number and assigns that word as secret.
	def generate_secret_word
	 dictionary = File.open("5desk.txt", "r")
	 total_words = dictionary.to_a
	 random_number = rand(61405)
	 @secret_word = total_words[random_number]
	 @secret_word = @secret_word.gsub(/\s+/,"")
	end

	#displays secret word as dashes by creating an array called @blanks.  This is updated
	#with letters as they are found.
	def display_as_secret(word)
		x = word.length
		@blanks = Array.new(x,"_")
	end
#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><<><><><>
	#user chooses letter
	def user_chooses_letter
		puts "\n"
		puts "LETTER CHOICES".center(106,"-")
		print_letter_choices(@display_array)
		puts "\nPlease enter a letter choice from the choices above:"
		@user_choice = gets.chomp.downcase
		if @user_choice == "save"
			save_game
			user_chooses_letter
		else
			valid_choice(@user_choice)

		end
	end

	#check to see if choice is valid if not it loops back.
		def valid_choice(choice)
		if @display_array.include?choice
			if @selection_array.include?choice
				puts "You have already chosen the letter #{choice}"
				user_chooses_letter
			else
				@selection_array.push(choice)
				puts "These are the lettter you have chosen so far:"
				print_letter_choices(@selection_array) 
			end
		else
			puts "Your choice is invalid"
			user_chooses_letter
		end
	end

	#This checks letters to see if they are correct
	def update_blanks(word,guess)
		@secret_word_array = word.split("")
		if @secret_word.include?(guess)
			@secret_word_array.each_with_index do |letter,idx|
				if letter == guess
					puts "\nNice one! #{guess} is in the word. You still have #{13-@count} lives left"
					@blanks[idx] = guess
					check_win
				end
			end
		else
			@count +=1
			puts "Ohh noo you lost a life you have #{13 - @count} lives left!"
		end
	end
	#checks for a win on each itteration.
	def check_win
		check = @blanks.join("")
	
		if @secret_word == check
			puts "\nWINNER WINNER CHICKEN DINNER!"
			puts "You got the word #{@secret_word}"
			play_again
		end
	end

#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><<><><><>
private
	#prints letter choises and selection out
	def print_letter_choices(arr)
		stop = arr.length
		arr.each_with_index do |letter, idx|
			if idx == 0
				print "| #{letter} |"
			elsif idx == (stop-1)
				puts " #{letter} |"
			else
				print " #{letter} |"
			end
		end
	end
	
	#prints secret word out	
	def print_secret_word(arr)
		stop = arr.length
		arr.each_with_index do |letter, idx|
			if idx == 0
				print " #{letter} "
			elsif idx == (stop-1)
				puts " #{letter} "
			else
				print " #{letter} "
			end
		end
	end

#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><<><><><>

	
	def reset
			 @selection_array =[]
			 play_game()
	end
public
#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><<><><><>

	def play_again
		puts "TYPE Y TO PLAY AGAIN?"
		answer = gets.chomp.capitalize
		if answer == "Y"
			reset()
		else
			abort("Thanks for playing!")
		end
	end

	


public
#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><<><><><>

#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><<><><><>
	def play_game
		@count = 0
		generate_secret_word		
		puts "WELCOME TO HANGMAN!".center(106,"<>")
		puts "\nThe aim of the Game is to guess the secret word. Everytime you get a guess wrong you loose a life."
		puts "You only have 13 lives.\n"
		puts "Type 'LOAD' to load a previous game or 'PLAY' to play!\n"
		welcome_answer = gets.chomp.upcase
		if welcome_answer == "LOAD"
			load_game
		elsif welcome_answer == "PLAY"
			display_as_secret(@secret_word)
		end
			puts "If you wish to save the game at any stage type Save"
			while @count < 13
				puts "THE SECRET WORD TO CRACK IS:".center(106,"-")
				print_secret_word(@blanks)
				user_chooses_letter
				update_blanks(@secret_word,@user_choice)
			end
			puts "YOU LOOSE!"
			puts "The word was #{@secret_word}"
			play_again
		end
end
#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><<><><><>

a = Game.new

a.play_game
