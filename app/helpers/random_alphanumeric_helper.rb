class RandomAlphanumericHelper

	def self.generate()
		Array.new(25){[*"A".."Z", *"0".."9", *"a".."z"].sample}.join
	end
end