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
