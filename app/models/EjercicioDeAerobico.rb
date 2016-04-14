require_relative  "../models/Ejercicio"

class EjercicioDeAerobico < Ejercicio

  	property :tiempoActivo, Integer
  	property :tiempoDescanso, Integer
  	has n, :marcas, :through => Resource

end
