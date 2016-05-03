FitnessTimeApi::App.controllers :rutinaService do

  post :registrarRutina, :map => '/rutinas' do
    securityToken = SecurityToken.find_by_authToken(params[:authToken])
    if securityToken == nil
      get_error_response(413,'Usuario no autorizado.')
    else
      begin
        rutina = create_rutina(params)
        rutina.save!()
        get_success_response(rutina.to_json)
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

  put :editarRutina, :map => '/rutinas/:rutina_id' do
    @rutina = Rutina.get(params[:rutina_id])
    actualizar_rutina(@rutina,params)
    #Comunicamos el resultado de la operacion y mandamos el json
  end

  delete :eliminarRutina, :map => '/rutinas/:rutina_id' do
    @rutina = Rutina.get(params[:rutina_id])
    @rutina.destroy!()
    #Comunicamos el resultado de la operacion y mandamos el json
  end

  get :consultar, :map => '/rutinas/:rutina_id' do
    @rutina = Rutina.get(params[:rutina_id])
    #Comunicamos el resultado de la operaicon y mandamos el json
  end

end
