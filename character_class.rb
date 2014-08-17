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
