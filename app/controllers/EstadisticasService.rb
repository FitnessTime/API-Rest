FitnessTimeApi::App.controllers :estadisticasService do
# Puede que mas adelante nos convenga "divir" el comportamiento por endidad a
# nivel objeto, pero es solo una idea.
  get :pasosDiarios , :map => '/estadisticas/pasos' do

  end

  get :kilometrosRecorridos , :map => '/estadisticas/kilometrosRecorridos' do

  end

  get :progresionDeCargas , :map => '/estadisticas/progresionDeCargas' do

  end

  post :pasosDiarios , :map => '/estadisticas/pasos' do

  end

  put :kilometrosRecorridos , :map => '/estadisticas/kilometrosRecorridos' do
    securityToken = SecurityToken.first(:emailUsuario => params[:email], :authToken => params[:authToken])
    if(securityToken == nil)
      get_error_response(404, "Usuario no autenticado")
    else
      jsonKilometro = JSON.parse(params[:kilometro])
      usuario = Usuario.find_by_email(securityToken.emailUsuario)
      kilometros = Kilometro.find_by_usuario_and_fecha(usuario, jsonKilometro["fecha"])
      if(kilometros == nil)
        create_kilometros(usuario, params)
        get_success_response("")
      else
        update_kilometros(kilometros, params)
        get_success_response("")
      end
    end
  end

  post :progresionDeCargas , :map => '/estadisticas/progresionDeCargas' do

  end
end
