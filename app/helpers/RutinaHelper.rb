require 'dm-serializer'

FitnessTimeApi::App.helpers do

  def actualizar_rutina(params)
    rutina = Rutina.find_by_id(params[:id])
    jsonRutina = JSON.parse(jsonRutina[:rutina])
    rutina.update(:inicio => jsonRutina['inicio'], :fin => jsonRutina['fin'],
    			   :descripcion => jsonRutina['descripcion'], :aclaracion => jsonRutina['aclaracion'])
    # if(rutina.rutina_de_carga?)
    #   actualizar_rutina_de_carga(rutina,params)
    # else
    #   actualizar_rutina_de_aerobico(rutina,params)
    # end
  end

  def create_rutina(params)
    jsonRutina = JSON.parse(params[:rutina])
    usuario = Usuario.find_by_email(jsonRutina['idUsuario'])
    rutina = Rutina.new()
    rutina.idMobile = jsonRutina['idMobile']
    rutina.inicio = jsonRutina['inicio']
  	rutina.fin = jsonRutina['fin']
    rutina.descripcion = jsonRutina['descripcion']
    rutina.aclaracion = jsonRutina['aclaracion']
    rutina.esDeCarga = jsonRutina['esDeCarga']
    rutina.estaSincronizado = true
    rutina.usuario = usuario
    lista = Array.new(jsonRutina['ejercicioList'].size)
    jsonRutina['ejercicio'].each do |ejercicio|
      ejer = crear_ejercicio(ejercicio, rutina)
    end
    rutina.save!()
    return rutina
  end

  # def actualizar_rutina_de_carga(rutina,params)
  #   update(:inicio => params[:inicio], :fin => params[:fin],
  #   			   :descripcion => params[:descripcion], :aclaracion => params[:aclaracion])
  # end
  #
  # def actualizar_rutina_de_aerobico(rutina,params)
  #
  # end

end
