require_relative '../DTOs/EjercicioDTO.rb'

class EjercicioAssembler

	def crear_dto (ejercicio, carga)
        ejercicioDTO = EjercicioDTO.new
        ejercicioDTO.idWeb = ejercicio.id
       	ejercicioDTO.idMobile = ejercicio.idMobile
        ejercicioDTO.nombre = ejercicio.nombre
        ejercicioDTO.diaDeLaSemana = ejercicio.diaDeLaSemana
        ejercicioDTO.series = ejercicio.series
        if(carga) 
            ejercicioDTO.repeticiones = ejercicio.repeticiones 
            ejercicioDTO.tiempoActivo = nil
            ejercicioDTO.tiempoDescanso = nil
        else 
            ejercicioDTO.repeticiones = nil 
            ejercicioDTO.tiempoActivo = ejercicio.tiempoActivo
            ejercicioDTO.tiempoDescanso = ejercicio.tiempoDescanso
        end
        ejercicioDTO.nombreCambio = ejercicio.nombreCambio
        ejercicioDTO.diaDeLaSemanaCambio = ejercicio.diaDeLaSemanaCambio
        ejercicioDTO.seriesCambio = ejercicio.seriesCambio
        ejercicioDTO.repeticionesCambio = ejercicio.repeticionesCambio
        ejercicioDTO.tiempoActivoCambio = ejercicio.tiempoActivoCambio
        ejercicioDTO.tiempoDescansoCambio = ejercicio.tiempoDescansoCambio
        ejercicioDTO.versionWeb = ejercicio.version
        ejercicioDTO.versionMobile = ejercicio.versionMobile
        ejercicioDTO.estaSincronizado = ejercicio.estaSincronizado
        ejercicioDTO.esDeCarga = carga
        ejercicioDTO.eliminada = ejercicio.eliminada
        ejercicioDTO.idRutina = ejercicio.rutina.id
        return ejercicioDTO
    end
end