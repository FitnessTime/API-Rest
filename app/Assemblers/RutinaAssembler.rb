require_relative '../DTOs/RutinaDTO.rb'

class RutinaAssembler

	def crear_dto (rutina)
        
        rutinaDTO = RutinaDTO.new
        rutinaDTO.idWeb = rutina.id
       	rutinaDTO.idMobile = rutina.idMobile
        rutinaDTO.inicio = rutina.inicio
        rutinaDTO.fin = rutina.fin
        rutinaDTO.descripcion = rutina.descripcion
        rutinaDTO.aclaracion = rutina.aclaracion
        rutinaDTO.versionWeb = rutina.version
        rutinaDTO.versionMobile = rutina.versionMobile
        rutinaDTO.estaSincronizado = rutina.estaSincronizado
        rutinaDTO.esDeCarga = rutina.esDeCarga
        rutinaDTO.eliminada = rutina.eliminada
        rutinaDTO.idUsuario = rutina.usuario.email
        rutinaDTO.inicioCambio = rutina.inicioCambio
        rutinaDTO.finCambio = rutina.finCambio
        rutinaDTO.descripcionCambio = rutina.descripcionCambio
        rutinaDTO.aclaracionCambio = rutina.aclaracionCambio

        ejerciciosDto = Array.new(rutina.ejercicios.size)
        assembler = EjercicioAssembler.new
        index = 0
        rutina.ejercicios.each do |ejercicio|
            ejerciciosDto[index] = assembler.crear_dto(ejercicio,rutina.esDeCarga)
            index = index + 1
        end

        rutinaDTO.ejerciciosDTO = ejerciciosDto
        return rutinaDTO
    end
end