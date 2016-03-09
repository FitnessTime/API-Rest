require 'json'

class SecurityToken 
	include DataMapper::Resource
	
	property :id, Serial
	
	property :idUsuario, Integer
	property :nombreUsuario, String
	property :emailUsuario, String
	property :authToken, String

	def initialize(emailUsuario, nombreUsuario, authToken)
		self.idUsuario = idUsuario
		self.nombreUsuario = nombreUsuario
		self.emailUsuario = emailUsuario
		self.authToken = authToken
	end

  	def self.json_create(o)
    	SecurityToken.new(o["emailUsuario"],o["nombreUsuario"],o["authToken"])
  	end
end
