FitnessTimeApi::App.helpers do

	def create_marca(jsonMarca, ejercicioDeCarga)

    	marca = Marca.new
    	marca.ejercicio = ejercicioDeCarga
    	marca.idMobile = jsonMarca['idMobile']
    	marca.carga = jsonMarca['carga']
    	marca.fecha = jsonMarca['fecha']
    	marca.save()
    	return marca
  	end
end
