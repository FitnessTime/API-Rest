require 'dm-serializer'

class SecurityToken 
	include DataMapper::Resource
	
	property :id, Serial
	property :emailUsuario, String
	property :nombreUsuario, String
	property :authToken, String

	def initialize(emailUsuario, nombreUsuario, authToken)
		self.nombreUsuario = nombreUsuario
		self.emailUsuario = emailUsuario
		self.authToken = authToken
	end

  	def self.json_create(o)
    	SecurityToken.new(o["emailUsuario"],o["nombreUsuario"],o["authToken"])
  	end
end
