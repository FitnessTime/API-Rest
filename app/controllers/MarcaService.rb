FitnessTimeApi::App.controllers :marcaService do

  post :registrarMarca, :map => '/rutinas/:rutina_id/ejercicios/:ejercicio_id/marcas' do
    # Verificamos que se pueda realizar la operacion
    # creamos la nueva marca
    # la agregamos al ejercicio
    # guardamos los cambios
    #Comunicamos el resultado de la operacion y mandamos el json
  end

  get :marcas, :map => '/rutinas/:rutina_id/ejercicios/:ejercicio_id/marcas' do
    # Verificamos que se pueda realizar la operacion
    @marcas = Ejercicio.get!(params[:ejercicio_id]).getMarcas()
    #Comunicamos el resultado de la operacion y mandamos el json
  end

  put :modificarEjercicio, :map => '/rutinas/:rutina_id/ejercicios/:ejercicio_id/marcas/:marca_id' do
    @marca = Marca.get!(params[:marca_id])
    #falta definir el metodo actualizar_marca
    #Comunicamos el resultado de la operacion y mandamos el json
  end

  delete :eliminar, :map => '/rutinas/:rutina_id/ejercicios/:ejercicio_id/marcas/:marca_id' do
    @marca = Marca.get!(params[:marca_id])
    @marca.destroy!()
    #Comunicamos el resultado de la operacion y mandamos el json
  end

  get :consultarEjercicio, :map => '/rutinas/:rutina_id/ejercicios/:ejercicio_id/marcas/:marca_id' do
    @marca = Marca.get!(params[:marca_id])
    #Comunicamos el resultado de la operacion y mandamos el json
  end
end
