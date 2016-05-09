require 'dm-serializer'

FitnessTimeApi::App.helpers do

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
