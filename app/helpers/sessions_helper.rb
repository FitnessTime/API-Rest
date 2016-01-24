FitnessTimeApi::App.helpers do
	
	def current_token=(token)
		@current_token = token 
	end

	def current_token
		@current_token = session[:current_token]
	end
	
	def sign_in(token)
		session[:current_token] = token 
		self.current_token = token
	end

	def sign_out
		session.delete(:current_token)
	end

	def signed_in?
		!current_token.nil?
	end

end