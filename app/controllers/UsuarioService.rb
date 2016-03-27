FitnessTimeApi::App.controllers :usuarioService do

  post :registrarUsuario, :map => '/registrarUsuari' do
    begin
      usuario = create_usuario(params)
      usuario.save
      enviar_mail_bienvenida(usuario.email, usuario.email, params[:pass])
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

  delete :eliminarCuenta, :map => '/eliminarCuenta' do
    Usuario.destroy(params[:email])
  end

  get :usuario, :map => '/usuario' do
    @usuario = Usuario.get(params[:email])
  end
end
