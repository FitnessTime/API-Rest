require 'dm-serializer'

FitnessTimeApi::App.helpers do

  def actualizar_ejercicio(jsonEjercicio)
    
    if(jsonEjercicio['esDeCarga'])
        ejercicio = EjercicioDeCarga.find_by_id(jsonEjercicio['idWeb'])
        versionWeb = ejercicio.version + 1
        ejercicio.update(:idMobile => jsonEjercicio['idMobile'], :nombre => jsonEjercicio['nombre'], :series => jsonEjercicio['series'],
                     :diaDeLaSemana => jsonEjercicio['diaDeLaSemana'], :versionMobile => jsonEjercicio['versionMobile'], 
                     :version => versionWeb, :repeticiones => jsonEjercicio['repeticiones'], 
                     :nombreCambio => jsonEjercicio['nombreCambio'], :seriesCambio => jsonEjercicio['seriesCambio'],
                     :diaDeLaSemanaCambio => jsonEjercicio['diaDeLaSemanaCambio'], :repeticionesCambio => jsonEjercicio['repeticionesCambio'],
                     :eliminada => jsonEjercicio['eliminada'], :estaSincronizado => true)
    else
        ejercicio = EjercicioDeAerobico.find_by_id(jsonEjercicio['idWeb'])
        versionWeb = ejercicio.version + 1
        ejercicio.update(:idMobile => jsonEjercicio['idMobile'], :nombre => jsonEjercicio['nombre'], :series => jsonEjercicio['series'],
                     :diaDeLaSemana => jsonEjercicio['diaDeLaSemana'], :versionMobile => jsonEjercicio['versionMobile'], 
                     :version => versionWeb, :diaDeLaSemanaCambio => jsonEjercicio['diaDeLaSemanaCambio'],
                     :tiempoActivo => jsonEjercicio['tiempoActivo'], :tiempoDescanso => jsonEjercicio['tiempoDescanso'], 
                     :nombreCambio => jsonEjercicio['nombreCambio'], :seriesCambio => jsonEjercicio['seriesCambio'],
                     :tiempoActivoCambio => jsonEjercicio['tiempoActivoCambio'], :tiempoDescansoCambio => jsonEjercicio['tiempoDescansoCambio'],
                     :eliminada => jsonEjercicio['eliminada'], :estaSincronizado => true)
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
    ejercicio.version = 0
    ejercicio.versionMobile = jsonEjercicio['versionMobile']
    ejercicio.nombreCambio = jsonEjercicio['nombreCambio']
    ejercicio.diaDeLaSemanaCambio = jsonEjercicio['diaDeLaSemanaCambio']
    ejercicio.seriesCambio = jsonEjercicio['seriesCambio']
    ejercicio.repeticionesCambio = jsonEjercicio['repeticionesCambio']
    ejercicio.tiempoActivoCambio = jsonEjercicio['tiempoActivoCambio']
    ejercicio.tiempoDescansoCambio = jsonEjercicio['tiempoDescansoCambio']
  	ejercicio.rutina = rutina
    if(jsonEjercicio['marcas'] != nil)
      jsonEjercicio['marcas'].each do |marca|
        ejer = create_marca(marca, ejercicio)
      end
    end
  	ejercicio.save!()
    return ejercicio
  end

  def eliminar_ejercicio(ejercicio)
    ejercicio.update(:eliminada => true, :estaSincronizado => true)
  end

  def retornar_ejercicios_dto(securityToken)
    ejercicios = Ejercicio.find_all_by_eliminada(false)
    ret_ejercicios_dto = Array.new(ejercicios.size)
    assembler = EjercicioAssembler.new
    index = 0
    ejercicios.each do |ejercicio|
      rutina = Rutina.find_by_id(ejercicio.rutina.id)
      ret_ejercicios_dto[index] = assembler.crear_dto(ejercicio, rutina.esDeCarga)
      index = index + 1
    end
    return ret_ejercicios_dto
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
                        :repeticionesCambio => false, :tiempoActivoCambio => false,
                        :tiempoDescansoCambio => false, :eliminada => ejercicioMobile['eliminada'],
                        :estaSincronizado => true, :idMobile => ejercicioMobile['idMobile'])
  end

  def sincronizar_ejercicios(jsonEjercicios, rutina)
    jsonEjercicios.each do |ejercicioMobile|
      if(ejercicioMobile['idWeb'] == nil)
        crear_ejercicio(ejercicioMobile, rutina)
      else
        if(ejercicioMobile['esDeCarga'])
            ejercicioWeb = EjercicioDeCarga.find_by_id(ejercicioMobile['idWeb'])
            sincronizar_marcas(ejercicioMobile['marcas'], ejercicioWeb)
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

  def get_cantidad_ejercicios_con_marcas(idRutina)
    count = 0
    ejercicios = Ejercicio.find_all_by_eliminada_and_type_and_rutina_id(false, 'EjercicioDeCarga' ,idRutina)
    ejercicios.each do |ejercicio|
      marcas = Marca.find_all_by_ejercicio_id(ejercicio.id)
      if(marcas != nil && marcas.size > 0)
        count = count + 1
      end
    end
    return count
  end

end
