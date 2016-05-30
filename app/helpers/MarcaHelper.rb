FitnessTimeApi::App.helpers do

	def create_marca(jsonMarca, ejercicioDeCarga)

		if(ejercicioDeCarga)
    		ejercicio = EjercicioDeCarga.find_by_id(jsonMarca['idEjercicio'])
    	else
    		ejercicio = EjercicioDeAerobico.find_by_id(jsonMarca['idEjercicio'])
    	end
    	marca = Marca.new
    	marca.ejercicio = ejercicio
    	marca.carga = jsonMarca['carga']
    	marca.fecha = jsonMarca['fecha']
    	marca.save()
    	return marca
  	end
end
