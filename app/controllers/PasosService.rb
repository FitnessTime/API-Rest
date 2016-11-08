
FitnessTimeApi::App.controllers :pasosService do
  
  post :registrarPasos, :map => '/pasos' do
    securityToken = SecurityToken.find_by_authToken(params[:authToken])
    if securityToken == nil
      get_error_response(404,"Usuario no autorizado.")
    else
      jsonPaso = JSON.parse(params[:paso])
      paso = Paso.find_by_fecha(jsonPaso['fecha'])
      if (paso == nil)
        nuevoPaso = Paso.new()
        nuevoPaso.fecha = jsonPaso['fecha']
        nuevoPaso.pasos_dados = jsonPaso['pasosDados']
        nuevoPaso.usuario = Usuario.find_by_email(jsonPaso['idUsuario'])
        nuevoPaso.save!()
      else
        paso.update(:pasos_dados => jsonPaso['pasosDados'])
      end
      get_success_response("")
    end
  end

end