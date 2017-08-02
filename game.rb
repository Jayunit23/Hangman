class Game
	#attr_accessor :
	load 'player.rb'

	
	def initialize
	 @player
	 @display_array = ('a'..'z').to_a
	 @selection_array =[]
	end
#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><<><><><>
	def generate_secret_word
	 dictionary = File.open("5desk.txt", "r")
	 total_words = dictionary.to_a
	 random_number = rand(61405)
	 @secret_word = total_words[random_number]
	 @secret_word = @secret_word.gsub(/\s+/,"")
	end
#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><<><><><>
	def display_as_secret(word)
		x = word.length
		@blanks = Array.new(x,"_")
	end
#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><<><><><>
	def update_blanks(word,guess)
		puts word
		@secret_word_array = word.split("")
		if @secret_word.include?(guess)
			@secret_word_array.each_with_index do |letter,idx|
				if letter == guess
					puts "#{guess} is in the word"
					puts idx
					puts guess
					@blanks[idx] = guess
				end
			end
		else
			@count +=1
			puts "count is #{@count}"
		end
	end
#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><<><><><>
private
	def print_letter_choices(arr)
		arr.each_with_index do |letter, idx|
			if idx == 0
				print "| #{letter} |"
			elsif idx == 25
				puts " #{letter} |"
			else
				print "#{letter} |"
			end
		end
	end
#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><<><><><>
	
	def valid_choice(choice)
		if @display_array.include?choice
			if @selection_array.include?choice
				puts "You have already chosen the letter #{choice}"
				user_chooses_letter
			else
				@selection_array.push(choice)
				print_letter_choices(@selection_array) 
			end
		else 
			puts "Your choice is invalid"
			user_chooses_letter
		end
	end
public
#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><<><><><>
	def user_chooses_letter
		puts "\nLETTER CHOICES"
		print_letter_choices(@display_array)
		puts "Please enter a letter choice from the choices above:"
		@user_choice = gets.chomp.downcase
		valid_choice(@user_choice)
	end

	def check_secret_word(choice)u
		secret_word
	end

	def play_game
		@count = 0
		generate_secret_word
		display_as_secret(@secret_word)
		while @count < 13

			print_letter_choices(@blanks)
			user_chooses_letter
			update_blanks(@secret_word,@user_choice) 	
		end
		puts "you loose"
		
	end


end
#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><<><><><>

a = Game.new
a.play_game

=begin
	
def display_as_secret(word)
		puts word
		@secret_word_array = word.split("")
		puts @secret_word_array	
		puts @secret_word_array.length	
		@secret_word_array.each do |letter|
			print " _"
			#print " #{letter}"
		end
	end
	
=end