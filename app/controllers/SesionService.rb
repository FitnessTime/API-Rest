FitnessTimeApi::App.controllers :sesionService do
  
  get :iniciarSesion, :map => '/login' do
    usuario = Usuario.find_by_email(params[:email])
      
    if usuario == nil
      #headers['X-Forwarded-For'] = request['X-Forwarded-For']
      get_error_response(404, "No existe el usuario")
    else if usuario.is_the_same_password?(params[:pass])
          securityToken = SecurityToken.new(usuario.email,usuario.nombre,generate_random)
          securityToken.save
          get_sucsses_response(securityToken.to_json)
        else
          get_error_response(404, "La contrasenia es incorrecta")
        end
      end
  end

  get :cerrarSesion, :map => '/close' do
    securityTokenBD = SecurityToken.first(:emailUsuario => params[:email], :authToken => params[:authToken])
    securityTokenBD.destroy
    get_sucsses_response('')
  end
end
