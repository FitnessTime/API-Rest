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
    if(rutina.esDeCarga)
    	ejercicio = EjercicioDeCarga.new
      ejercicio.repeticiones = jsonEjercicio['repeticiones']
    else
      ejercicio = EjercicioDeAerobico.new
      ejercicio.tiempoActivo = jsonEjercicio['tiempoActivo']
      ejercicio.tiempoDescanso = jsonEjercicio['tiempoDescanso']
    end
  	ejercicio.nombre = jsonEjercicio['nombre']
  	ejercicio.diaDeLaSemana = jsonEjercicio['diaDeLaSemana']
  	ejercicio.series = jsonEjercicio['series']
    ejercicio.estaSincronizado = true
    ejercicio.idMobile = jsonEjercicio['idMobile']
    ejercicio.eliminada = jsonEjercicio['eliminada']
  	ejercicio.rutina = rutina
  	ejercicio.save()
    return ejercicio
  end

  def merge_ejercicio(ejercicioMobile)
    if(ejercicioMobile['esDeCarga'])
        ejercicioWeb = EjercicioDeCarga.find_by_id(ejercicioMobile['idWeb'])
        if(ejercicioMobile['repeticionesCambio'])
            ejercicioWeb.update(:repeticiones => ejercicioMobile['repeticiones'])
        end
    else
        ejercicioWeb = EjercicioDeAerobico.find_by_id(ejercicioMobile['idWeb'])
        if(ejercicioMobile['tiempoDescansoCambio'])
            ejercicioWeb.update(:tiempoDescanso => ejercicioMobile['tiempoDescanso'])
        end
        if(ejercicioMobile['tiempoActivoCambio'])
            ejercicioWeb.update(:tiempoActivo => ejercicioMobile['tiempoActivo'])
        end
    end
    if(ejercicioMobile['nombreCambio'])
      ejercicioWeb.update(:nombre => ejercicioMobile['nombre'])
    end
    if(ejercicioMobile['diaDeLaSemanaCambio'])
      ejercicioWeb.update(:diaDeLaSemana => ejercicioMobile['diaDeLaSemana'])
    end
    if(ejercicioMobile['seriesCambio'])
      ejercicioWeb.update(:series => ejercicioMobile['series'])
    end
    
    ejercicioWeb.update(:nombreCambio => false, :diaDeLaSemanaCambio => false, :seriesCambio => false,
                        :repeticionesCambio => false, :tiempoActivoCambio => false, :tiempoDescansoCambio => false)
  end

  def sincronizar_ejercicios(jsonEjercicios, rutina)
    jsonEjercicios.each do |ejercicioMobile|
      if(ejercicioMobile['idWeb'] == nil)
        crear_ejercicio(ejercicioMobile, rutina)
      else
        if(ejercicioMobile['esDeCarga'])
            ejercicioWeb = EjercicioDeCarga.find_by_id(ejercicioMobile['idWeb'])
        else
            ejercicioWeb = EjercicioDeAerobico.find_by_id(ejercicioMobile['idWeb'])
        end
        if(ejercicioWeb.version > ejercicioMobile['versionWeb'])
          merge_ejercicio(ejercicioMobile)
        else
          actualizar_ejercicio(ejercicioMobile)
        end
      end
    end  
  end

end
