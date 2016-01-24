class EjercicioDeAerobico
	include DataMapper::Resource
	
	property :id, Serial

  	property :nombre, String
  	property :series, Integer
  	property :tiempoActivo, Integer
  	property :tiempoDescanso, Integer
  	has n, :rutina_de_aerobicos, :through => Resource

end