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
