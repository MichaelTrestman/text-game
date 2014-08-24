require 'yaml'

#classes

class Character

	@@all_characters = {}

	def self.all_list
		puts @@all_characters
	end

	attr_accessor :name, :species, :gender, :health, :dexterity, :strength, :magic, :spells, :armor, :gold, :weapon, :inventory, :xp, :history
								
	def initialize(name, species, gender, health, dexterity, strength, magic, spells, armor, gold, weapon, inventory, xp, history)
		@name = name
		@species = species
		@gender = gender
		@armor = armor
		@gold = gold
		@inventory = inventory
		@xp = xp
		@health = health
		@dexterity = dexterity
		@strength = strength
		@magic = magic
		@spells = spells
		@weapon = weapon
		@history = history
		
		@@all_characters[@name] = self

	end

	def display_char
		print "Name: #{@name} \n\t
		species: #{@species}\n\t
		Sex: #{@gender} \n\t
		health: #{@health[0]}/#{@health[1]}\n\t
		weapon: #{@weapon.name}; damage: #{@weapon.damage}
		strength: #{@strength[0]} / strength-baseline: #{strength[1]} \n\t
		dexterity: #{@dexterity[0]} / dexterity-baseline: #{dexterity[1]}\n\t
		magic: #{@magic[0]} / magic-max: #{@magic[1]}\n\t
		spells: #{@spells}\n\t
		armor: #{@armor[0]}; protection: #{@armor[1]}\n\t
		gold: #{@gold}\n\t
		inventory: #{@inventory}\n\t
		unspent xp: #{@xp}\n\t
		history: #{@history}\n\t		"
	end

	def display_enemy
		print "Name: #{@name} \n\t
		species: #{@species}\n\t
		Sex: #{@gender} \n\t
		health: #{@health[0]}/#{@health[1]}\n\t
		weapon: #{@weapon.name}; damage: #{@weapon.damage}
		strength: #{@strength[0]} / strength-baseline: #{strength[1]} \n\t
		dexterity: #{@dexterity[0]} / dexterity-baseline: #{dexterity[1]}\n\t
		magic: #{@magic[0]} / magic-max: #{@magic[1]}\n\t
		spells: #{@spells}\n\t
		armor: #{@armor[0]}; protection: #{@armor[1]}\n\t
		reward: #{@gold}\n\t
		inventory: #{@inventory}\n\t
		xp reward: #{@xp}\n\t
		"
	end


	def attack(target)
		puts "#{@name} attacks #{target.name} with #{@weapon.name}!"
		if ( rand(100).to_f * (@dexterity[0].to_f / target.dexterity[0].to_f )).to_i > 90
			puts "ouch, a critical hit!"
			crit = true
			hit = true	
			dam = (@weapon.damage.to_f * 2.0 * (@strength[0].to_f / target.strength[0].to_f)).to_i

			target.health[0] -= dam
			puts "#{target.name} suffers #{dam} damage"
		elsif ( rand(100).to_f * ( @dexterity[0].to_f / target.dexterity[0].to_f) ).to_i > 50
			crit = false
			hit = true
			dam = (   (@weapon.damage.to_f  * ( @strength[0].to_f / target.strength[0].to_f ) ).to_i  - target.armor[1]) 
			target.health[0] -= dam unless dam < 0
			puts "the attack hits. #{target.name}'s armor offers #{target.armor[1]} protection. #{target.name} takes #{dam} damage."
		else
			crit = false
			hit = false
			puts "the attack misses"
		end
	end

	def recover
		@dexterity[0] += 10 if @dexterity[0] < @dexterity[1] 
		@dexterity[0] -= 10 if @dexterity[0] > @dexterity[1] 
		@strength[0] += 10 if @strength[0] < @strength[1] 
		@strength[0] -= 10 if @strength[0] > @strength[1] 
		@magic[0] += 10 if @magic[0] < @magic[1] 
	end
end

class Weapon
	@@all_weapons = {}

	def self.all_list
		@@all_weapons
	end
	attr_accessor :name, :damage
	def initialize name, damage

		@damage = damage #base damage from hit
		@name = name

		@@all_weapons[name] = self
	end

	def name
		@name
	end

	def damage
		@damage
	end

	def display
		puts "name: #{@name}"
		puts "damage: #{@damage}"
	end

end

class Spell
	@@all_spells = []
	def self.all_list
		@@all_spells
	end

	attr_accessor :name, :health_effect, :magic_cost, :dex_effect, :strength_effect

	def initialize(name, health_effect, magic_cost, dex_effect, strength_effect)
		@name = name
		@health_effect = health_effect
		@magic_cost = magic_cost
		@dex_effect = dex_effect
		@strength_effect = strength_effect
		@@all_spells << self
	end
	
	def cast_on(caster, target)
		puts "#{caster.name} casts #{self.name} on #{target.name}!"
		target.health[0] += @health_effect
		caster.magic[0] -= @magic_cost
		target.dexterity[0] += @dex_effect
		target.strength[0] += @strength_effect
	end

end

heal_spell = Spell.new("heal wounds", 50, 50, 0, 0)
dex_boost_spell = Spell.new("boost dexterity",  0, 50, 50, 0)
str_boost_spell = Spell.new("boost strength", 0, 50, 0, 50)
dex_drain_spell = Spell.new("drain dexterity", 0, 50, -50, 0)
str_drain_spell = Spell.new("drain strength", 0, 50, 0, -50)


#Useful methods

def spacer
	puts
	puts "---------------------------------"
	puts
end

def prompt 
	print ">";
end

def get_ans(x, y)
	spacer
	ans = 999
	until ans>=x && ans<=y
		prompt
		ans = gets.chomp.to_i

	end
	return ans
end


def choice_menu(choices)

	choices.each do |option|
		if option.class == Character
			opt_name = option.name
		elsif option.class == Weapon
			opt_name = option.name
		elsif option.class == Spell
			opt_name = option.name
		else
			opt_name = option
		end
		num = choices.index(option)
		puts "\t #{num}. >#{opt_name} "
	end

	choice = get_ans(0, choices.length)
	return choices[choice]
end



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



def new_game


	species_list = ["human", "elf", "orc", "xenomorph", "were-walrus", "fun-vampire", "wookie", "humanimal", "chupacabra", "gungan"]
	
	genders_list = ["male", "female", "xemale", "indeterminate", "both", "neither"]	

	armors_list = [   ["cardboard and bottle-caps held together with duck-tape", 5], 
										["mithril chain mail", 20], 
										["rusty iron chain-mail", 10],
										["styrofoam full-plate", 10],
										["teflon-coated chain-mail", 15], 
										[ "gilded elven hockey mask and pads", 40], 
										["scaled steel armor", 35], 
										["batman suit", 50], 
										["MJOLNIR Mark VII Powered Assault Armor", 100] ]

	
	weapons_list =[ ["a frigging lightsaber", 150],
								  ["daedric chainsaw", 100],
								["elven flame-thrower", 90],
								["Sawed-Off Shotgun of Hoosiering", 75],
								["mithril pizza slicer and barbecue fork",  60],
								["sanctified uzi of demon-slaying",  80],
								["rusty sword", 20] ]



	spacer
	puts "Welcome to character creation!"
	puts "enter your character's name:"
	prompt
	name = gets.chomp

	spacer
	puts "enter your character's species"
	species = choice_menu(species_list)

	spacer
	puts "enter your character's sex"
	gender = choice_menu(genders_list)
	
	xp = 0
	armor = ["slave rags", 0]
	gold = 0
	inventory = ["umm, something narratively compelling?", "useful items perhaps?"]
	history = ["sold into slavery (sucks!!)"]

	health = [100, 100]
	dexterity = [100, 100]
	strength = [100, 100]
	magic = [100, 100]
	spells = []
	weapon = Weapon.new("sharpened broom-handle", 20)

	char_matrix = [name, species, gender, health, dexterity, strength, magic, spells, armor, gold, weapon, inventory, xp, history]
	char = Character.new(*char_matrix)

	#ok, time to create some enemies!

	names_list = ["Jimbob",  
		"Bloody Mary", 
		"Klip-Klop son of Bleeblor", 
		"Gandoff the Grody", 
		"Borky Bork-Bork", 
		"Glibberdorff the Veracious", 
		"Broberta Killstein", 
		"Sven Somethingson"] 
	available_enemies = []

	available_enemies <<  Character.new("Fartarella", "orc", "female", [100, 100], [80, 80], [120, 120], [20,20], ["nada"], ["crappy plastic armor", 0], 70, Weapon.new("a crappy club", 20), ["jack squat"], 15, ["you have no clue"])
	available_enemies <<  Character.new("Zingleberry", "elf", "male", [100, 100], [130, 130], [40, 40], [100, 100], ["nada"], ["poodle-skin hauberk", 7], 85, Weapon.new("a stick covered in poop", 20), ["jack squat"], 25, ["you have no clue"])


	until names_list.length == 0 do

		w = weapons_list[rand(weapons_list.length - 1)]
		
		z = Character.new(  names_list[rand(names_list.length - 1)], 
								species_list[rand(species_list.length - 1)], 
								genders_list[rand(genders_list.length - 1)], 
								[h = rand(100) + 80, h], 
								[d = rand(100) + 50, d], 
								[s = rand(100) + 50, s], 
								[m = rand(100) + 50, m], 
								["some spells?"], 
								armors_list[rand(armors_list.length - 1)], 

								(  (rand(100) + 10) * ( rand(5) + 2) ), 
								Weapon.new(w[0], w[1]),

								
								["umm inventory items?"], 
								(30 * d/100), 
								["some history maybes?"])
		available_enemies << z
		names_list.delete(z.name)

	end

	[char, available_enemies]
end


def match(char, enemy)
	20.times {char.recover}
	spacer
	puts "You and #{enemy.name} enter the ring. only one of you may exit! Dun dun duuuuun!!!"
	gets
	puts "The crowd is on their feet, cheering, mad for blood!"

	your_turn = rand(100) * char.dexterity[0] / enemy.dexterity[0]

	your_turn > 50 ? your_turn = true : your_turn = false

	match_over = false

	until match_over do 
		spacer
		if your_turn

			char.recover

			puts "Your turn! Look, then act!"
			spacer
			puts "Look:"
			case choice_menu(["your status", "examine enemy", "examine arena", "skip"])
			when "your status"
				char.display_char
				gets
			when "examine enemy"
				enemy.display_enemy
				gets
			when "examine arena"
				puts "Situational clue! (this isn't implemented yet)"
			when "skip"
			end
			spacer
			puts "Act:"

			choices = ["attack",  "cast spell", "use item", "beg for mercy"]

			#choices << situational_action if one is available...

			case choice_menu(choices)
			when "attack"
				char.attack(enemy)
				match_over = true if enemy.health[0] <= 0
				gets
			
			when "beg for mercy"
				puts "unfortunately #{enemy.name} is fresh out of mercy. you are savagely slaughtered as the crowd cheers."
				puts "THE END. Score: negative a million points."
				exit
			when "cast spell"

				puts "which spell?"
				
				spell = choice_menu(char.spells)
				puts "cast #{spell.name} on whom?"
				target = choice_menu([char, enemy])

				spell.cast_on(char, target)
				puts "you cast #{spell.name} on #{target}!"

			end
			your_turn = false

			
		else
			enemy.recover
			enemy.attack(char)

			match_over = true if char.health[0] <= 0
				
			gets
			your_turn = true		
		end
	end

	if char.health[0] <= 0 
		puts "you die! too bad"
		puts "THE END. Score: negative a million points."
		exit
	else
		puts "yay! you win! congratulations on murdering one of your fellow slaves for the entertainment of the rich!"
		
	end
	20.times {char.recover}
	char.health[0] = char.health[1]
	[char, enemy]
end






armors_list = [   ["cardboard and bottle-caps held together with duck-tape", 5], 
										["mithril chain mail", 20], 
										["rusty iron chain-mail", 10],
										["styrofoam full-plate", 10],
										["teflon-coated chain-mail", 15], 
										[ "gilded elven hockey mask and pads", 40], 
										["scaled steel armor", 35], 
										["batman suit", 50], 
										["MJOLNIR Mark VII Powered Assault Armor", 100] ]

	
	weapons_list =[ ["a frigging lightsaber", 150],
								  ["daedric chainsaw", 100],
								["elven flame-thrower", 90],
								["Sawed-Off Shotgun of Hoosiering", 75],
								["mithril pizza slicer and barbecue fork",  60],
								["sanctified uzi of demon-slaying",  80],
								["rusty sword", 20] ]

puts "Welcome to Gladiator Death Match 3000!!!"
spacer

case choice_menu(["new game", "load game"])

when "new game"
	z = new_game
	char = z[0]
	available_enemies = z[1]

when "load game"
	z = load_your_game
	char = z[0]
	available_enemies = z[1]
end


#ok, this is the game actually running...
poor = Proc.new {puts "not enough gold or xp! go win a fight, you bum!" }

zorkle = "shnorkle"
until zorkle == "quit"
	
	zorkle = choice_menu(["find a match", "upgrades", "save game", "quit"])

	case zorkle

	when "quit"
			puts "So long, loser!"
			exit

	when "upgrades"
		spacer

		puts "xp: #{char.xp}; gold: #{char.gold}"

		badorkle = "shnorkle"

		until badorkle == "leave upgrades"
			puts
			badorkle = choice_menu(["improve attributes", "purchase gear", "acquire spells", "leave upgrades"])
			case badorkle
			when "purchase gear"
				spacer
				shmixorkle = "shnorkle"
				until shmixorkle == "leave purchase gear"					
					shmixorkle = choice_menu(["purchase armor", "purchase weapon", "leave purchase gear"])
					case shmixorkle
					when "purchase armor"
						puts "current gold: #{char.gold}"
						armor_store = armors_list
						armor_store << "leave purchase armor"		
						blizzorkle = "snorkle"				
						until blizzorkle == "leave purchase armor"
							blizzorkle = choice_menu(armor_store)
							unless blizzorkle == "leave purchase armor"
								if char.gold >= blizzorkle[1]
								char.gold -= blizzorkle[1]
								char.armor = blizzorkle
								
								puts "your new armor is #{blizzorkle}!"
								else
								poor.call
								end
							end
						end

					when "purchase weapon"
						puts "current gold: #{char.gold}"
						weapon_store = weapons_list
						weapon_store << "leave purchase weapon"		
						blizzorkle = "snorkle"								
						until blizzorkle == "leave purchase weapon"
							blizzorkle = choice_menu(weapon_store)
							unless blizzorkle == "leave purchase weapon"
								if char.gold >= blizzorkle[1]
								char.gold -= blizzorkle[1]
								char.weapon = Weapon.new blizzorkle[0], blizzorkle[1]
								
								puts "your new weapon is #{blizzorkle}!"
								else
								poor.call
								end
							end
						end
					end
				end

			when "improve attributes"
				spacer
				shmixorkle = "shnorkle"
				until shmixorkle == "leave improve attributes"
					#char.display_char
					shmixorkle = choice_menu(["increase dexterity %10; cost: 25 xp", "increase strength %10; cost: 25 xp", "increase magic %10; cost: 25 xp", "leave improve attributes"])
		
					case shmixorkle
					

					when "increase dexterity %10; cost: 25 xp"
						puts
						if char.xp >= 25
							char.xp -= 25
							char.dexterity[1] = ( (char.dexterity[1].to_f) * 1.1).to_i
							#5.times {char.recover}
							puts "dexterity has been increased to #{char.dexterity[1]}"
						else
							poor.call
						end
					end
				end
			

			when "acquire spells"
				spacer
				shmixorkle = "shnorkle"
				spell_store = Spell.all_list
				
				spell_store << "leave acquire spells"

				until shmixorkle == "leave acquire spells"
					shmixorkle = choice_menu(spell_store)
					case shmixorkle
					when "leave acquire spells"

					when heal_spell
						puts " heals caster 50 pts at a cost of 50 magic"
						puts
						puts "purchase for 15 xp?"
						case choice_menu(["yes", "no"])
						when "yes"
							if char.xp >= 15
								char.spells << heal_spell
								char.xp -= 15
								puts "you have acquired heal wounds"
							else 
								poor.call
							end
						when "no"
						end
					when dex_boost_spell
						puts "boosts caster's dex 50 pts at a cost of 50 magic"
						puts
						puts "purchase for 35 xp?"
						case choice_menu(["yes", "no"])
						when "yes"
							if char.xp >= 35
								char.spells << dex_boost_spell
								char.xp -= 35
								puts "you have acquired boost dexterity"
							else 
								poor.call
							end
						when "no"
						end
						
					when str_boost_spell
						puts "boosts caster's strength 50 pts at a cost of 50 magic"
						puts
						puts "purchase for 25 xp?"
						case choice_menu(["yes", "no"])
						when "yes"
							if char.xp >= 25
								char.spells << str_boost_spell
								char.xp -= 25
								puts "you have acquired boost strength"
							else 
								poor.call
							end
						when "no"
						end

					when dex_drain_spell
						puts "drains target's dex 50 pts at a cost of 50 magic"
						puts
						puts "purchase for 45 xp?"
						case choice_menu(["yes", "no"])
						when "yes"
							if char.xp >= 45
								char.spells << dex_drain_spell
								char.xp -= 45
								puts "you have acquired boost strength"
							else 
								poor.call
							end
						when "no"
						end
					when str_drain_spell
						puts "drain's target's dex 50 pts at a cost of 50 magic"
						puts
						puts "purchase for 50 xp?"
						case choice_menu(["yes", "no"])
						when "yes"
							if char.xp >= 50
								char.spells << str_drain_spell
								char.xp -= 50
								puts "you have acquired drain strength"
							else 
								poor.call
							end
						when "no"
						end
					end
				end
			end
		end
	
		
	when "find a match"

		puts "List of available opponents. Choose for more info"

		choices = available_enemies
		choices << "don't fight now"
		choice = choice_menu(choices)
		unless choice == "don't fight now"
			spacer	
			choice.display_enemy 
			puts "Challenge #{choice.name} to a match?"
			if choice_menu(["yes", "no"]) == "yes" 
				zeblop = match(char, choice)
				char = zeblop[0]
				char.history << "killed #{zeblop[1]}"
				puts "you have gained #{zeblop[1].xp} xp and #{zeblop[1].gold} gold. congratulations!"
				
				char.xp += zeblop[1].xp
				char.gold += zeblop[1].gold
				available_enemies.delete(zeblop[1])
			else 
				choice = choice_menu(choices)
			end
		end
	
	when "save game"
			save_your_game(char, available_enemies)
	end
end




#character creation
#generate enemy list


#def save game

#def load game

#def match
#def upgrades


#welcome

#day

	#match

	#upgrades


#Classes













