require "json"

class StUsuario

	attr_accessor :id
	attr_accessor :nombre
	attr_accessor :email
	attr_accessor :fechaNacimiento
	attr_accessor :peso
	attr_accessor :diasDeEntrenamiento
	attr_accessor :minimoDePasosDiarios
	attr_accessor :minimoDeKilometrosRecorridos

	def initialize(id,nombre,email,fechanacimiento,peso,diasentrenamiento,minimopasos,minimokilometros)
		@id = id
		@nombre = nombre
		@email = email
		@fechaNacimiento = fechanacimiento
		@peso = peso
		@diasDeEntrenamiento = diasentrenamiento
		@minimoDeKilometrosRecorridos = minimokilometros
		@minimoDePasosDiarios = minimopasos
	end

	def to_json(*a)
	    {
	      "json_class"   => self.class.name,
	      "data"         => {'id'=>@id, 'nombre'=>@nombre, 'email'=>@email, 'fechaNacimiento'=>@fechaNacimiento, 'peso'=>@peso,
			 				 'diasDeEntrenamiento'=>@diasDeEntrenamiento, 'minimoDePasosDiarios'=>@minimoDePasosDiarios,
			 				 'minimoDeKilometrosRecorridos'=>@minimoDeKilometrosRecorridos}
	    }.to_json(*a)
  	end

	def self.json_create(o)
    	new(o["data"]["id"],o["data"]["nombre"], o["data"]["email"], o["data"]["fechaNacimiento"], o["data"]["peso"],
    		o["data"]["diasDeEntrenamiento"], o["data"]["minimoDePasosDiarios"], o["data"]["minimoDeKilometrosRecorridos"])
  	end
end