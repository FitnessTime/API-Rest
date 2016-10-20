require_relative '../exceptions/DifferentPasswordError'

FitnessTimeApi::App.controllers :sesionService do

  get :iniciarSesion, :map => '/login' do
    begin
      usuario = Usuario.get!(params[:email])
      if(usuario.is_the_same_password?(params[:pass]))
        if(usuario.activo)
          securityToken = SecurityToken.new(usuario.email,usuario.nombre,generate_random,"", usuario.fechaNacimiento, usuario.peso, usuario.minimoDePasosDiarios)
          securityToken.save()
          get_success_response(securityToken.to_json)
        else
          get_error_response(404, "Cuenta no activada.")
        end
      else
        get_error_response(404, "La contrasenia es incorrecta.")
      end
    rescue DataMapper::ObjectNotFoundError => e
      get_error_response(404, "No existe el usuario")
    end
  end

  get :activarCuenta, :map => '/activar' do
    usuario = Usuario.get!(params[:email])
    usuario.update(:activo => true)
  end

  get :cerrarSesion, :map => '/close' do
    securityToken = SecurityToken.find_by_authToken(params[:authToken])
    securityToken.destroy()
    get_success_response('')
  end
end
