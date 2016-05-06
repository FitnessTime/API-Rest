require_relative '../exceptions/DifferentPasswordError'

FitnessTimeApi::App.controllers :sesionService do

  get :iniciarSesion, :map => '/login' do
    begin
      usuario = Usuario.get!(params[:email])
      if(usuario.is_the_same_password?(params[:pass]))
        securityToken = SecurityToken.new(usuario.email,usuario.nombre,generate_random)
        securityToken.save()
        get_success_response({"nombreUsuario":securityToken.nombreUsuario, "emailUsuario":securityToken.emailUsuario, "authToken":securityToken.authToken, "imagenPerfil":""}.to_json)
        #get_success_response(securityToken.to_json)
      else
        get_error_response(404, "La contrasenia es incorrecta.")
      end
    rescue DataMapper::ObjectNotFoundError => e
      get_error_response(404, "No existe el usuario")
    end
  end

  get :cerrarSesion, :map => '/close' do
    securityTokenBD = SecurityToken.first(:emailUsuario => params[:email], :authToken => params[:authToken])
    securityTokenBD.destroy()
    get_success_response('')
  end
end
