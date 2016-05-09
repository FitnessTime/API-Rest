FitnessTimeApi::App.controllers :ejercicioService do

  post :registrarEjercicio, :map => '/ejercicios' do
    securityToken = SecurityToken.find_by_authToken(params[:authToken])
    if securityToken == nil
      get_error_response(404,"Usuario no autorizado.")
    else
      jsonEjercicio = JSON.parse(params[:ejercicio])
      rutina = Rutina.find_by_id(params[:idRutina])
      ejercicio = create_ejercicio(jsonEjercicio,rutina)
      
    end
  end

  get :ejercicios, :map => '/rutinas/:rutina_id/ejercicios' do
    # Verificamos que se pueda realizar la operacion
    @usuario = Usuario.get([:email])
    @rutinas = @usuario.getRutinas()
    get_success_response(@rutinas.getEjercicios().to_json())
    #Comunicamos el resultado de la operacion y mandamos el json
  end

  put :modificarEjercicio, :map => '/rutinas/:rutina_id/ejercicios/:ejercicio_id' do
    @rutina = Rutina.get(params[:rutina_id])
    #falta definir el metodo actualizar_rutina
    actualizar_rutina(@rutina,params)
    #Comunicamos el resultado de la operacion y mandamos el json
  end

  delete :eliminar, :map => '/rutinas/:rutina_id/ejercicios/:ejercicio_id' do
    @rutina = Rutina.get(params[:rutina_id])
    @rutina.destroy()
    #Comunicamos el resultado de la operacion y mandamos el json
  end

  get :consultarEjercicio, :map => '/rutinas/:rutina_id/ejercicios/:ejercicio_id' do
    @rutina = Rutina.get(params[:rutina_id])
    #Comunicamos el resultado de la operacion y mandamos el json
  end
end
