require_relative '../Assemblers/RutinaAssembler.rb'

FitnessTimeApi::App.controllers :rutinaService do

  post :registrarRutina, :map => '/rutinas' do
    securityToken = SecurityToken.find_by_authToken(params[:authToken])
    if securityToken == nil
      get_error_response(413,'Usuario no autorizado.')
    else
      begin
        jsonRutina = JSON.parse(params[:rutina])
        rutina = create_rutina(jsonRutina)
        assembler = RutinaAssembler.new
        rutinaDTO = assembler.crear_dto(rutina)
        get_success_response(rutinaDTO.to_json)
      rescue DataMapper::SaveFailureError
        get_error_response(404,'No se pudo crear la rutina')
      end
    end
  end

  get :rutinas, :map => '/rutinas' do
      securityToken = SecurityToken.find_by_authToken(params[:authToken])
      if securityToken == nil
        get_error_response(404,"Usuario no autorizado.")
      else
        usuario = Usuario.find_by_email(securityToken.emailUsuario)
        rutinas = Rutina.find_all_by_usuario(usuario)
        get_success_response(rutinas.to_json)
      end
  end

  put :editarRutina, :map => '/rutinas' do
    securityToken = SecurityToken.find_by_authToken(params[:authToken])
    if securityToken == nil
      get_error_response(404,"Usuario no autorizado.")
    else
      jsonRutina = JSON.parse(params[:rutina])
      rutina_actualizada = actualizar_rutina(jsonRutina)
      assembler = RutinaAssembler.new
      rutinaDTO = assembler.crear_dto(rutina_actualizada)
      get_success_response(rutinaDTO.to_json)
    end
  end

  delete :eliminarRutina, :map => '/rutinas' do
    securityToken = SecurityToken.find_by_authToken(params[:authToken])
    if securityToken == nil
      get_error_response(404,"Usuario no autorizado.")
    else
      rutina = Rutina.find_by_id(params[:id])
      rutina.update(:eliminada => true, :estaSincronizado => true)
      assembler = RutinaAssembler.new
      rutinaDTO = assembler.crear_dto(rutina)
      get_success_response(rutinaDTO.to_json)
    end
  end

  get :consultar, :map => '/rutinas/:rutina_id' do
    @rutina = Rutina.get(params[:rutina_id])
  end

  get :sincronizar, :map => '/rutinaSinc' do
    securityToken = SecurityToken.find_by_authToken(params[:authToken])
    if securityToken == nil
      get_error_response(404,"Usuario no autorizado.")
    else
      
      index = 0
      assembler = RutinaAssembler.new
      rutinas = JSON.parse(params[:rutinas])
      lista = Array.new(rutinas.size)
      rutinas.each do |rutinaMobile|
        #rutinaWeb = Rutina.find_by_id(rutinaMobile['idWeb'])
        if(rutinaMobile['idWeb'] == nil)
          lista[index] = create_rutina(rutinaMobile)
        else
          if(rutinaWeb.version > rutinaMobile.versionWeb)
            lista[index] = assembler.crear_dto(rutinaWeb)
          else
            if(rutinaWeb.version == rutinaMobile.versionWeb && rutinaWeb.versionMobile < rutinaMobile.versionMobile)
              
            else

            end
          end
        end
        index = index + 1
      end
      get_success_response(lista.to_json)
    end
  end

end
