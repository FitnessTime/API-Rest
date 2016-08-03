FitnessTimeApi::App.helpers do

	def create_marca(jsonMarca, ejercicioDeCarga)

    	marca = Marca.new
    	marca.ejercicio = ejercicioDeCarga
    	marca.idMobile = jsonMarca['idMobile']
    	marca.carga = jsonMarca['carga']
    	marca.fecha = jsonMarca['fecha']
    	marca.save!()
    	return marca
  	end

  	def sincronizar_marcas(jsonMarcas)
  		jsonMarcas.each do |marcaMobile|
  			marca = Marca.find_by_id(marcaMobile['idWeb'])
  			if(marca == nil)
  				ejercicio = EjercicioDeCarga.find_by_id(marcaMobile['ejercicioId'])
  				create_marca(marcaMobile, ejercicio)
  			end
  		end
  	end
end
