FitnessTimeApi::App.controllers :ejercicioService do

  # Asi es como me gustaria que sea... no se si funciona...
  post :registrarEjercicio, :map => '/rutinas/#{@rutina.id}/registrarEjercicio' do
    # Verificamos que se pueda realizar la operacion
    @ejercicio = create_ejercicio(params)
    @ejercicio.save
  end

  get :ejercicios, :map => '/rutinas/#{@rutina.id}/ejercicios' do
    # Verificamos que se pueda realizar la operacion
    @usuario = Usuario.get([:email])
    @rutinas = @usuario.getRutinas()
    # devolvemos el json en el response
  end

  get :modificarEjercicio, :with => :rutina_id do
    @rutina = Rutina.get(params[:rutina_id])
    #falta definir el metodo actualizar_rutina
    actualizar_rutina(@rutina)
    render '/rutinas/#{@rutina.id}'
  end

  get :eliminar, :with => :rutina_id do
    @rutina = Rutina.get(params[:rutina_id])
    @rutina.destroy
    render '/rutinas'
  end

  get :consultar, :with => :rutina_id do
    @rutina = Rutina.get(params[:rutina_id])
    render '/rutinas/#{@rutina.id}'
  end
end
