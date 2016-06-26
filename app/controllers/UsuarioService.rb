FitnessTimeApi::App.controllers :usuarioService do

  post :registrarUsuario, :map => '/usuarios' do
    begin
      usuario = create_usuario(params)
      usuario.save!()
      jsonUsuario = JSON.parse(params[:usuario])
      enviar_mail_bienvenida(usuario.email, usuario.email, jsonUsuario['password'])
      get_success_response("Usuario creado con exito.")
    rescue Exception
      get_error_response(404,"Ya existe un usuario con esta cuenta.")
    end
  end

  put :modificarUsuario, :map => '/usuarios' do
    securityToken = SecurityToken.find_by_authToken(params[:authToken])
    if(securityToken == nil)
      get_error_response(412,'Usuario no autenticado')
    else
      jsonUsuario = JSON.parse(params[:usuario])
      usuario = Usuario.find_by_email(jsonUsuario['email'])
      usuario = update_usuario(usuario,jsonUsuario)
      securityToken.update(:nombreUsuario => usuario.nombre, :fechaNacimientoUsuario => usuario.fechaNacimiento,
                           :pesoUsuario => usuario.peso)
      get_success_response(securityToken.to_json)
    end
  end

  put :cambiarContrasenia, :map => '/cambiarContrasenia' do
    securityToken = SecurityToken.first(:emailUsuario => params[:email], :authToken => params[:authToken])
    if(securityToken == nil)
      get_error_response(404,"Usuario no autenticado")
    else
      cambiar_contrasenia(params)
      get_success_response("Contrasenia cambiada con exito.")
    end
  end

  delete :eliminarCuenta, :map => '/eliminarCuenta' do
    Usuario.destroy(params[:email])
  end

  get :usuario, :map => '/usuario' do
    @usuario = Usuario.get(params[:email])
    get_success_response(@usuario.to_json)
  end
end
