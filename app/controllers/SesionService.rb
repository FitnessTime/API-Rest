FitnessTimeApi::App.controllers :sesionService do

  get :iniciarSesion, :map => '/login' do
    begin
      usuario = Usuario.get(params[:email])
      securityToken = SecurityToken.new(usuario.email,usuario.nombre,generate_random)
      securityToken.save
      get_sucsses_response(securityToken.to_json)
    rescue ObjectNotFoundError => e
      get_error_response(404, "No existe el usuario")
    rescue DifferentPasswordError => e
      get_error_response(404, e.message())
    end
  end

  get :cerrarSesion, :map => '/close' do
    securityTokenBD = SecurityToken.first(:emailUsuario => params[:email], :authToken => params[:authToken])
    securityTokenBD.destroy
    get_sucsses_response('')
  end
end
