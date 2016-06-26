require 'dm-serializer'

class SecurityToken 
	include DataMapper::Resource
	
	property :id, Serial
	property :emailUsuario, String
	property :nombreUsuario, String
	property :authToken, String
	property :imagenPerfil, String
	property :fechaNacimientoUsuario, Date
	property :pesoUsuario, Integer

	def initialize(emailUsuario, nombreUsuario, authToken, imagenPerfil, fechaNacimientoUsuario, pesoUsuario)
		self.nombreUsuario = nombreUsuario
		self.emailUsuario = emailUsuario
		self.authToken = authToken
		self.imagenPerfil = imagenPerfil
		self.fechaNacimientoUsuario = fechaNacimientoUsuario
		self.pesoUsuario = pesoUsuario
	end

  	def self.json_create(o)
    	SecurityToken.new(o["emailUsuario"],o["nombreUsuario"],o["authToken"], o["imagenPerfil"],
    					  o["fechaNacimientoUsuario"], o["pesoUsuario"])
  	end
end
