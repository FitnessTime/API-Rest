require "json"

class SecurityToken 
	include DataMapper::Resource
	
	property :id, Serial
	
	property :idUsuario, Integer
	property :nombreUsuario, String
	property :emailUsuario, String
	property :authToken, String

	def initialize(idUsuario, nombreUsuario, emailUsuario, authToken)
		self.idUsuario = idUsuario
		self.nombreUsuario = nombreUsuario
		self.emailUsuario = emailUsuario
		self.authToken = authToken
	end

	def to_json(*a)
	    {
	      "json_class"   => self.class.name,
	      "data"         => {'idUsuario'=>idUsuario, 'nombreUsuario'=>nombreUsuario,
	      					 'emailUsuario'=>emailUsuario, 'authToken'=>authToken}
	    }.to_json(*a)
  	end

  	def self.json_create(o)
    	SecurityToken.new(o["data"]["idUsuario"],o["data"]["nombreUsuario"],o["data"]["emailUsuario"],o["data"]["authToken"])
  	end
end
