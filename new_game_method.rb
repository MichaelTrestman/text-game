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
		"Roberta Millstein", 
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
