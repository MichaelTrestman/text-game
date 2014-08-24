require 'sqlite3'

p 'please enter a game-save name'
game_save_name = gets.chomp

$db = SQLite3::Database.new "#{game_save_name}.db"


$db.execute %Q{
	create table weapons (
		id INTEGER PRIMARY KEY,
		name varchar (50),
		power int
	);}

[ ["a frigging lightsaber", 150],
	["daedric chainsaw", 100],
	["elven flame-thrower", 90],
	["Sawed-Off Shotgun of Hoosiering", 75],
	["mithril pizza slicer and barbecue fork",  60],
	["sanctified uzi of demon-slaying",  80],
	["rusty sword", 20] 
].each { |w| 
	$db.execute("INSERT INTO weapons (name, power)
            VALUES (?, ?)", [ w[0], w[1] ])
 }

display_all_weapons = Proc.new {
	weapons = $db.execute %Q{
		select * from weapons;
	}
	weapons.each { |w| 
		w.each { |e| 
			print e
			print "  |  "
		 }		
	 }
}

$db.execute %Q{

	create table armors (
		id INTEGER PRIMARY KEY,
		name varchar (50),
		power int
	);}

[ ["cardboard and bottle-caps held together with duck-tape", 5], 
	["mithril chain mail", 20], 
	["rusty iron chain-mail", 10],
	["styrofoam full-plate", 10],
	["teflon-coated chain-mail", 15], 
	[ "gilded elven hockey mask and pads", 40], 
	["scaled steel armor", 35], 
	["batman suit", 50], 
	["MJOLNIR Mark VII Powered Assault Armor", 100] 
].each { |w| 
	$db.execute("INSERT INTO armors (name, power)
            VALUES (?, ?)", [ w[0], w[1] ])
 }

display_all_armors = Proc.new{
	armors = $db.execute %Q{
		select * from armors;
	}
	armors.each { |w| 
		w.each { |e| 
			print e
			print "  |  "
		 }
		 puts	
	};
}


$db.execute %Q{	
	create table characters (
		id INTEGER PRIMARY KEY,
		name varchar (500),
		species varchar (500),
		gender varchar (500),
		health int,
		dexterity int,
		strength int,
		magic int,
		armor int,
		gold int,
		weapon int,
		xp int
	);}


names_list = ["Jimbob",  
		"Bloody Mary", 
		"Klip-Klop son of Bleeblor", 
		"Gandoff the Grody", 
		"Borky Bork-Bork", 
		"Glibberdorff the Veracious", 
		"Broberta Killstein", 
		"Sven Somethingson"] 
	available_enemies = []

species_list = ["human", "elf", "orc", "xenomorph", "were-walrus", "fun-vampire", "wookie", "humanimal", "chupacabra", "gungan"]
	
genders_list = ["male", "female", "xemale", "indeterminate", "both", "neither"]	

names_list.shuffle!

until names_list.empty? do
	#pick name off of list
	name = names_list.pop
	#pick random weapon
	weaponz = $db.execute %Q{
		select id, name from weapons
	}
	weapon = weaponz.sample
	#pick random armor
	armorz = $db.execute %Q{
		select id, name from armors
	}
	armor = armorz.sample

	$db.execute(%Q{
		INSERT INTO characters (name, species, gender, health, dexterity, strength, magic, armor, gold, weapon, xp)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}, [ 
            	
            	# array of all the parameters for character creation!
            	name,
            	species_list[rand(species_list.length - 1)], 
				genders_list[rand(genders_list.length - 1)], 
				(rand(100) + 80), 
				(rand(100) + 50), 
				(rand(100) + 50), 
				(rand(100) + 50), 
	# 						["some spells?"], 
				armor[0],

				(  (rand(100) + 10) * ( rand(5) + 2) ), 
	# 						Weapon.new(w[0], w[1]),

	# 						["umm inventory items?"], 
	# 						(30 * d/100), 
	# 						["some history maybes?"])
	
            	weapon[0],
            	( (rand(100) + 50))
    ])

	# id INTEGER PRIMARY KEY,
		# name varchar (500),
		# species varchar (500),
		# gender varchar (500),
		# health int,
		# dexterity int,
		# strength int,
		# magic int,
		# armor int,
		# gold int,
		# weapon int,
		# xp int
end	

# code for actually creating the spells as objects. but for here we just have to create them as db items, so the relationship of characters to castable spells can be kept track of.

# heal_spell = Spell.new("heal wounds", 50, 50, 0, 0)
# dex_boost_spell = Spell.new("boost dexterity",  0, 50, 50, 0)
# str_boost_spell = Spell.new("boost strength", 0, 50, 0, 50)
# dex_drain_spell = Spell.new("drain dexterity", 0, 50, -50, 0)
# str_drain_spell = Spell.new("drain strength", 0, 50, 0, -50)

# name, health_effect, magic_cost, dex_effect, strength_effect



	# z = Character.new(  names_list[rand(names_list.length - 1)], 
	# 						species_list[rand(species_list.length - 1)], 
	# 						genders_list[rand(genders_list.length - 1)], 
	# 						[h = rand(100) + 80, h], 
	# 						[d = rand(100) + 50, d], 
	# 						[s = rand(100) + 50, s], 
	# 						[m = rand(100) + 50, m], 
	# 						["some spells?"], 
	# 						armors_list[rand(armors_list.length - 1)], 

	# 						(  (rand(100) + 10) * ( rand(5) + 2) ), 
	# 						Weapon.new(w[0], w[1]),

	# 						["umm inventory items?"], 
	# 						(30 * d/100), 
	# 						["some history maybes?"])
	# available_enemies << z
	# names_list.delete(z.name)




$db.execute %Q{
	create table spells (
		name varchar (500),
		health_effect int,
		magic_cost int,
		dex_effect int,
		strength_effect int
	);}




