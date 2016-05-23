require 'dm-serializer'

FitnessTimeApi::App.helpers do

  def actualizar_ejercicio(jsonEjercicio)
    
    if(jsonEjercicio['esDeCarga'])
        ejercicio = EjercicioDeCarga.find_by_id(jsonEjercicio['idWeb'])
        versionWeb = ejercicio.version + 1
        ejercicio.update(:nombre => jsonEjercicio['nombre'], :series => jsonEjercicio['series'],
                     :diaDeLaSemana => jsonEjercicio['diaDeLaSemana'], :versionMobile => jsonEjercicio['versionMobile'], 
                     :version => versionWeb, :repeticiones => jsonEjercicio['repeticiones'], 
                     :nombreCambio => jsonEjercicio['nombreCambio'], :seriesCambio => jsonEjercicio['seriesCambio'],
                     :diaDeLaSemanaCambio => jsonEjercicio['diaDeLaSemanaCambio'], :repeticionesCambio => jsonEjercicio['repeticionesCambio'],
                     :estaSincronizado => true)
    else
        ejercicio = EjercicioDeAerobico.find_by_id(jsonEjercicio['idWeb'])
        versionWeb = ejercicio.version + 1
        ejercicio.update(:nombre => jsonEjercicio['nombre'], :series => jsonEjercicio['series'],
                     :diaDeLaSemana => jsonEjercicio['diaDeLaSemana'], :versionMobile => jsonEjercicio['versionMobile'], 
                     :version => versionWeb, :diaDeLaSemanaCambio => jsonEjercicio['diaDeLaSemanaCambio'],
                     :tiempoActivo => jsonEjercicio['tiempoActivo'], :tiempoDescanso => jsonEjercicio['tiempoDescanso'], 
                     :nombreCambio => jsonEjercicio['nombreCambio'], :seriesCambio => jsonEjercicio['seriesCambio'],
                     :tiempoActivoCambio => jsonEjercicio['tiempoActivoCambio'], :tiempoDescansoCambio => jsonEjercicio['tiempoDescansoCambio'],
                     :estaSincronizado => true)
    end
    return ejercicio
  end

  def crear_ejercicio(jsonEjercicio, rutina)
    if(jsonEjercicio['esDeCarga'])
    	ejercicio = EjercicioDeCarga.new
    	ejercicio.nombre = jsonEjercicio['nombre']
    	ejercicio.diaDeLaSemana = jsonEjercicio['diaDeLaSemana']
    	ejercicio.series = jsonEjercicio['series']
    	ejercicio.repeticiones = jsonEjercicio['repeticiones']
        ejercicio.estaSincronizado = true
        ejercicio.idMobile = jsonEjercicio['idMobile']
        ejercicio.eliminada = jsonEjercicio['eliminada']
    	ejercicio.rutina = rutina
    	ejercicio.save()
    else
    	ejercicio = EjercicioDeAerobico.new
    	ejercicio.nombre = jsonEjercicio['nombre']
    	ejercicio.diaDeLaSemana = jsonEjercicio['diaDeLaSemana']
    	ejercicio.series = jsonEjercicio['series']
    	ejercicio.tiempoActivo = jsonEjercicio['tiempoActivo']
    	ejercicio.tiempoDescanso = jsonEjercicio['tiempoDescanso']
        ejercicio.estaSincronizado = true
        ejercicio.idMobile = jsonEjercicio['idMobile']
        ejercicio.eliminada = jsonEjercicio['eliminada']
    	ejercicio.rutina = rutina
    	ejercicio.save()
    end
    return ejercicio
  end

end
