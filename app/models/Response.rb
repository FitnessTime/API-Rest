require 'dm-serializer'

class Response 
	include DataMapper::Resource

	property :id, Serial
	property :codigo, Integer
	property :mensaje, String

	def initialize(codigo, mensaje)
		self.codigo = codigo
		self.mensaje = mensaje
	end

end