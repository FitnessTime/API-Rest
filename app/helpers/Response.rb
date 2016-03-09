FitnessTimeApi::App.helpers do

	def get_error_response(code,data)
		[code, {'content-Type'=>'text/plain'}, data]
	end

	def get_error()
		[404, {'content-Type'=>'text/plain'}, 'Error']
	end

	def get_sucsses(data, headers)
		[200, headers, data]
	end

	def get_sucsses_response(data)
		[200, {'content-Type'=>'text/plain'}, data]
	end
end