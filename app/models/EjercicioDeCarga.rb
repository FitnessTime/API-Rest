require_relative  "../models/Ejercicio"

class EjercicioDeCarga < Ejercicio

	property :repeticiones, Integer
	property :repeticionesCambio, Boolean
    has n, :marcas, :through => Resource
end
