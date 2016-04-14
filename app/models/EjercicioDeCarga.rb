require_relative  "../models/Ejercicio"

class EjercicioDeCarga < Ejercicio

	property :repeticiones, Integer
    has n, :marcas, :through => Resource
end
