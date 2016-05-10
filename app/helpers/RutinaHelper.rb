require 'dm-serializer'

FitnessTimeApi::App.helpers do

  def actualizar_rutina(jsonRutina)
    rutina = Rutina.find_by_id(jsonRutina['idWeb'])
    versionWeb = rutina.version + 1
    rutina.update(:inicio => jsonRutina['inicio'], :fin => jsonRutina['fin'],
    			        :descripcion => jsonRutina['descripcion'], :aclaracion => jsonRutina['aclaracion'],
                  :versionMobile => jsonRutina['versionMobile'], :version => versionWeb, :estaSincronizado => true)
    return rutina
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
    rutina.eliminada = jsonRutina['eliminada']
    rutina.estaSincronizado = true
    rutina.usuario = usuario
    jsonRutina['ejercicios'].each do |ejercicio|
      ejer = crear_ejercicio(ejercicio, rutina)
    end
    rutina.save!()
    return rutina
  end
end
