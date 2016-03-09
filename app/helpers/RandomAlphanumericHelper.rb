FitnessTimeApi::App.helpers do

	def generate_random()
		Array.new(25){[*"A".."Z", *"0".."9", *"a".."z"].sample}.join
	end
end