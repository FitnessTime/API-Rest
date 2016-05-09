require_relative '../DTOs/EjercicioDTO.rb'

class EjercicioAssembler

	def crear_dto (ejercicio)
        ejercicioDTO = RutinaDTO.new
        ejercicioDTO.idWeb = ejercicio.id
       	ejercicioDTO.idMobile = ejercicio.idMobile
        ejercicioDTO.inicio = ejercicio.inicio
        ejercicioDTO.fin = ejercicio.fin
        ejercicioDTO.descripcion = ejercicio.descripcion
        ejercicioDTO.aclaracion = ejercicio.aclaracion
        ejercicioDTO.versionWeb = ejercicio.version
        ejercicioDTO.versionMobile = ejercicio.versionMobile
        ejercicioDTO.estaSincronizado = ejercicio.estaSincronizado
        ejercicioDTO.esDeCarga = ejercicio.esDeCarga
        ejercicioDTO.eliminada = ejercicio.eliminada
        ejercicioDTO.idUsuario = ejercicio.usuario.email
        return ejercicioDTO
    end
end