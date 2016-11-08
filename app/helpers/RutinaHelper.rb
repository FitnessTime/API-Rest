require 'dm-serializer'

FitnessTimeApi::App.helpers do

  def actualizar_rutina(jsonRutina)
    rutina = Rutina.find_by_id(jsonRutina['idWeb'])
    versionWeb = rutina.version + 1
    rutina.update(:idMobile => jsonRutina['idMobile'], :inicio => jsonRutina['inicio'], :fin => jsonRutina['fin'],
    			        :descripcion => jsonRutina['descripcion'], :aclaracion => jsonRutina['aclaracion'],
                  :versionMobile => jsonRutina['versionMobile'], :version => versionWeb,
                  :inicioCambio => jsonRutina['inicioCambio'], :finCambio => jsonRutina['finCambio'], 
                  :aclaracionCambio => jsonRutina['aclaracionCambio'], :descripcionCambio => jsonRutina['descripcionCambio'], 
                  :eliminada => jsonRutina['eliminada'] , :estaSincronizado => true)
    return rutina
  end

  def create_rutina(jsonRutina)
    usuario = Usuario.find_by_email(jsonRutina['idUsuario'])
    rutina = Rutina.new()
    rutina.idMobile = jsonRutina['idMobile']
    rutina.inicio = jsonRutina['inicio']
  	rutina.fin = jsonRutina['fin']
    rutina.descripcion = jsonRutina['descripcion']
    rutina.aclaracion = jsonRutina['aclaracion']
    rutina.esDeCarga = jsonRutina['esDeCarga']
    rutina.eliminada = jsonRutina['eliminada']
    rutina.inicioCambio = jsonRutina['inicioCambio']
    rutina.finCambio = jsonRutina['finCambio']
    rutina.descripcionCambio = jsonRutina['descripcionCambio']
    rutina.aclaracionCambio = jsonRutina['aclaracionCambio']
    rutina.estaSincronizado = true
    rutina.version = 0;
    rutina.usuario = usuario
    if(jsonRutina['ejercicios'] != nil)
      jsonRutina['ejercicios'].each do |ejercicio|
        ejer = crear_ejercicio(ejercicio, rutina)
      end
    end
    rutina.save!()
    return rutina
  end

  def eliminar_rutina(params)
    rutina = Rutina.find_by_id(params[:id])
    rutina.update(:eliminada => true, :estaSincronizado => true)
    if(rutina.ejercicios != nil)
      rutina.ejercicios.each do |ejercicio|
        eliminar_ejercicio(ejercicio)
      end
    end
    assembler = RutinaAssembler.new
    rutinaDTO = assembler.crear_dto(rutina)
    return rutinaDTO
  end

  def retornar_rutinas_no_eliminadas_dto(securityToken)
    rutinas = Rutina.find_all_by_usuario_email_and_eliminada(securityToken.emailUsuario, false)
    ret_rutinas_dto = Array.new(rutinas.size)
    assembler = RutinaAssembler.new
    index = 0
    rutinas.each do |rutina|
      ret_rutinas_dto[index] = assembler.crear_dto(rutina)
      index = index + 1
    end
    return ret_rutinas_dto
  end

  def retornar_rutinas_dto(securityToken)
    rutinas = Rutina.find_all_by_usuario_email(securityToken.emailUsuario)
    ret_rutinas_dto = Array.new(rutinas.size)
    assembler = RutinaAssembler.new
    index = 0
    rutinas.each do |rutina|
      ret_rutinas_dto[index] = assembler.crear_dto(rutina)
      index = index + 1
    end
    return ret_rutinas_dto
  end

  def merge_rutina(rutinaMobile)
    rutinaWeb = Rutina.find_by_id(rutinaMobile['idWeb'])
    if(rutinaMobile['finCambio'])
      rutinaWeb.update(:fin => rutinaMobile['fin'])
    end
    if(rutinaMobile['inicioCambio'])
      rutinaWeb.update(:inicio => rutinaMobile['inicio'])
    end
    if(rutinaMobile['aclaracionCambio'])
      rutinaWeb.update(:aclaracion => rutinaMobile['aclaracion'])
    end
    if(rutinaMobile['descripcionCambio'])
      rutinaWeb.update(:descripcion => rutinaMobile['descripcion'])
    end
    rutinaWeb.update(:finCambio => false, :inicioCambio => false, :aclaracionCambio => false,
                     :descripcionCambio => false, :eliminada => rutinaMobile['eliminada'],
                     :estaSincronizado => true, :idMobile => rutinaMobile['idMobile'])
  end

  def sincronizar_rutinas(jsonRutinas)
    jsonRutinas.each do |rutinaMobile|
      if(rutinaMobile['idWeb'] == nil)
        rutinaWeb = create_rutina(rutinaMobile)
      else
        rutinaWeb = Rutina.find_by_id(rutinaMobile['idWeb'])
        if not rutinaWeb.eliminada
          if(rutinaWeb.version > rutinaMobile['versionWeb'])
            merge_rutina(rutinaMobile)
          else
            actualizar_rutina(rutinaMobile)
          end
          sincronizar_ejercicios(rutinaMobile['ejercicios'], rutinaWeb)
        end
      end
      
    end  
  end
 
  def get_cantidad_rutinas_con_ejercicios_con_marcas(securityToken)
    count = 0
    rutinas = Rutina.find_all_by_eliminada_and_usuario_email(false, securityToken.emailUsuario)
    rutinas.each do |rutinaCount|
      tieneEjerciciosConMarcas = false
      rutinaCount.ejercicios.each do |ejercicioCount|
        marcas = Marca.find_all_by_ejercicio_id(ejercicioCount.id)
        if(marcas != nil && marcas.size > 0)
          tieneEjerciciosConMarcas = true
        end
      end
      if tieneEjerciciosConMarcas
        count = count + 1
      end
    end
    return count
  end

end
