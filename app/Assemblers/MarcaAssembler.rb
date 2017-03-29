require_relative '../DTOs/MarcaDTO.rb'

class MarcaAssembler

	def crear_dto (marca)
        
        marcaDTO = MarcaDTO.new
        marcaDTO.idWeb = marca.id
       	marcaDTO.idMobile = marca.idMobile
        marcaDTO.fecha = marca.fecha
        marcaDTO.carga = marca.carga
        marcaDTO.idEjercicio = marca.ejercicio.id

        return marcaDTO
    end
end
