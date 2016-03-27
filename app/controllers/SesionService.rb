require_relative '../exceptions/DifferentPasswordError'

FitnessTimeApi::App.controllers :sesionService do

  get :iniciarSesion, :map => '/login' do
    begin
      usuario = Usuario.get!(params[:email])
      securityToken = SecurityToken.new(usuario.email,usuario.nombre,generate_random)
      securityToken.save()
      get_success_response(securityToken.to_json)
    rescue DifferentPasswordError => e
      get_error_response(404, e.message())
    rescue DataMapper::ObjectNotFoundError => e
      get_error_response(404, "No existe el usuario")
    end
  end

  get :cerrarSesion, :map => '/close' do
    securityTokenBD = SecurityToken.first(:emailUsuario => params[:email], :authToken => params[:authToken])
    securityTokenBD.destroy
    get_success_response('')
  end
end
