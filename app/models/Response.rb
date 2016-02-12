class Response

	def self.get_error_response(code,data)
		[code, {'content-Type'=>'text/plain'}, data.to_json]
	end

	def self.get_error()
		[404, {'content-Type'=>'text/plain'}, 'Error']
	end

	def self.get_sucsses_response(data, headers)
		[200, headers, data]
	end

	def self.get_sucsses(data)
		[200, {'content-Type'=>'text/plain'}, data]
	end
end