require_relative '../DTOs/MarcaDTO.rb'

class MarcaAssembler

	def crear_dto (marca)
        
        marcaDTO = MarcaDTO.new
        marcaDTO.idWeb = marca.id
       	marcaDTO.idMobile = marca.idMobile
        marcaDTO.fecha = rutina.inicio
        marcaDTO.carga = rutina.fin
        marcaDTO.idEjercicio = marca.ejercicio.id

        return marcaDTO
    end
end
