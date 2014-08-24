def save_your_game(char, available_enemies)

	puts "enter save name:"
	prompt

	save_name = gets.chomp + ".txt"

	save_game = [char.name, char.species, char.gender, char.health, char.dexterity, char.strength, char.magic, char.spells, char.armor, char.gold, char.weapon, char.inventory, char.xp, char.history, available_enemies].to_yaml
	

	#this saves your game info
	File.open save_name, 'w' do |f|
		f.write save_game
	end
	#this adds the name of your saved game to a list of saved games, so you can pick the right saved game later in the load game function
	yam_list_of_old_saves = File.read "list_of_old_saves.txt"
	list_of_old_saves = YAML::load yam_list_of_old_saves #this should be an array of all the saved games
	list_of_old_saves << save_name
	yam_list_of_old_saves = list_of_old_saves.to_yaml
	File.open "list_of_old_saves.txt", 'w' do |f|
		f.write yam_list_of_old_saves
	end
end

def load_your_game
	
	yam_list_of_old_saves = File.read "list_of_old_saves.txt"
	list_of_old_saves = YAML::load yam_list_of_old_saves

	load_name = choice_menu(list_of_old_saves)
	yam_char_matrix = File.read load_name
	char_matrix = YAML::load yam_char_matrix
	available_enemies = char_matrix.pop
	char = Character.new(*char_matrix)
	[char, available_enemies]
end