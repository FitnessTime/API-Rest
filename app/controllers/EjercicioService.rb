FitnessTimeApi::App.controllers :ejercicioService do

  post :registrarEjercicio, :map => '/rutinas/:rutina_id/ejercicios' do
    # Verificamos que se pueda realizar la operacion
    @ejercicio = create_ejercicio(params)
    @ejercicio.save()
    #Comunicamos el resultado de la operacion y mandamos el json
  end

  get :ejercicios, :map => '/rutinas/:rutina_id/ejercicios' do
    # Verificamos que se pueda realizar la operacion
    @usuario = Usuario.get([:email])
    @rutinas = @usuario.getRutinas()
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
