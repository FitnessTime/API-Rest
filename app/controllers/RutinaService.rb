FitnessTimeApi::App.controllers :rutinaService do

  post :registrarRutina, :map => '/rutinas' do
    securityToken = SecurityToken.find_by_authToken(:authToken => params[:authToken])
    if securityToken == nil
      get_error_response(413,'Usuario no autorizado.')
    end
    #Creamos la rutina
    #Guardamos la rutina
    #Comunicamos el resultado de la operacion y mandamos el json
  end

  get :rutinas, :map => '/rutinas' do
      @usuario = Usuario.get([:email])
      @rutinas = @usuario.getRutinas()
      #Comunicamos el resultado de la operacicon y mandamos el json
  end

  put :editarRutina, :map => '/rutinas/:rutina_id' do
    @rutina = Rutina.get(params[:rutina_id])
    #falta definir el metodo actualizar_rutina
    actualizar_rutina(@rutina)
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
