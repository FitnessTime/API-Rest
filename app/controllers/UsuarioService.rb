FitnessTimeApi::App.controllers :usuarioService do

  get :registrarUsuario, :map => '/registrarUsuario' do
    begin
      usuario = create_usuario(params)
      usuario.save!()
      jsonUsuario = JSON.parse(params[:usuario])
      enviar_mail_bienvenida(usuario.email, usuario.email, jsonUsuario['password'])
      get_success_response('Usuario creado con exito.')
    rescue DataMapper::SaveFailureError
      get_error_response(410,'Ya existe un usuario con esta cuenta.')
    end
  end

  put :modificarUsuario, :map => '/modificarUsuario' do
    securityToken = SecurityToken.first(:emailUsuario => params[:email], :authToken => params[:authToken])
    if(securityToken == nil)
      get_error_response(412,'Usuario no autenticado')
    else
      @usuario = Usuario.find_by_email(params[:email])
      @usuario = update_usuario(@usuario,params)
      get_success_response('Usuario modificado con exito.')
    end
  end

  get :cambiarContrasenia, :map => '/cambiarContrasenia' do
    securityToken = SecurityToken.first(:emailUsuario => params[:email], :authToken => params[:authToken])
    if(securityToken == nil)
      get_error_response(412,'Usuario no autenticado'.to_json)
    else
      @usuario = Usuario.find_by_email(params[:email])
      pass = ::BCrypt::Password.create(params[:nuevaPass]) unless params[:nuevaPass].nil?
      @usuario.update(:crypted_password => pass)
      get_success_response('Contrasenia cambiada con exito.')
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
