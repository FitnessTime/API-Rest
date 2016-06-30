require_relative '../Assemblers/MarcaAssembler.rb'

FitnessTimeApi::App.controllers :marcaService do
  
  post :registrarMarca, :map => '/marcas' do
    securityToken = SecurityToken.find_by_authToken(params[:authToken])
    if securityToken == nil
      get_error_response(404,"Usuario no autorizado.")
    else
      jsonMarca = JSON.parse(params[:marca])
      ejercicio = EjercicioDeCarga.find_by_id(jsonMarca['idEjercicio'])
      marca = create_marca(jsonMarca, ejercicio)
      get_success_response("")
    end
  end

  get :marcas, :map => '/rutinas/:rutina_id/ejercicios/:ejercicio_id/marcas' do
    # Verificamos que se pueda realizar la operacion
    @marcas = Ejercicio.get!(params[:ejercicio_id]).getMarcas()
    #Comunicamos el resultado de la operacion y mandamos el json
  end

  get :consultarEjercicio, :map => '/rutinas/:rutina_id/ejercicios/:ejercicio_id/marcas/:marca_id' do
    @marca = Marca.get!(params[:marca_id])
    #Comunicamos el resultado de la operacion y mandamos el json
  end
end
