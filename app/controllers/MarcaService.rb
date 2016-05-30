FitnessTimeApi::App.controllers :marcaService do
  
  post :registrarMarca, :map => '/marcas' do
    # Verificamos que se pueda realizar la operacion
    marca = create_marca(params)
    marca.save()
    #Comunicamos el resultado de la operacion y mandamos el json
  end

  get :marcas, :map => '/rutinas/:rutina_id/ejercicios/:ejercicio_id/marcas' do
    # Verificamos que se pueda realizar la operacion
    @marcas = Ejercicio.get!(params[:ejercicio_id]).getMarcas()
    #Comunicamos el resultado de la operacion y mandamos el json
  end

  put :modificarEjercicio, :map => '/rutinas/:rutina_id/ejercicios/:ejercicio_id/marcas/:marca_id' do
    @marca = Marca.get!(params[:marca_id])
    actualizar_marca(@marca,params)
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
