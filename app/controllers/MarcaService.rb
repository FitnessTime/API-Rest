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

end
