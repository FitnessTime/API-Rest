class EjercicioDeAerobico
	include DataMapper::Resource

	property :id, Serial , :key => true

  	property :nombre, String
  	property :series, Integer
  	property :tiempoActivo, Integer
  	property :tiempoDescanso, Integer
  	has n, :marcas, :through => Resource
	belongs_to :rutina_de_aerobico

end
