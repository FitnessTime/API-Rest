FitnessTimeApi::App.controllers :usuarioService do
  #  Para que iba el :map?
  get :registrarUsuario, :map => '/registrarUsuario' do
    begin
      usuario = create_usuario(params)
      usuario.save
      enviar_mail_bienvenida(usuario.email, usuario.email, params[:pass])
      get_sucsses_response('Usuario creado con exito.')
    rescue Exception
      get_error_response(410,'Ya existe un usuario con esta cuenta.')
    end
  end

  get :modificarUsuario, :map => '/modificarUsuario' do
    securityToken = SecurityToken.first(:emailUsuario => params[:email], :authToken => params[:authToken])
    if(securityToken == nil)
      get_error_response(412,'Usuario no autenticado')
    else
      @usuario = Usuario.find_by_email(params[:email])
      @usuario = update_usuario(@usuario,params)
      get_sucsses_response('Usuario modificado con exito.')
    end
  end

  get :eliminarCuenta, :map => '/eliminarCuenta' do
    #validamos que pueda realizar la operaciones
    Usuario.destroy(params[:email])
    # cerramos la sesion eliminando el codigo de autenticacion.

    # mandamos en el response el mensaje de que esta todo ok
  end

  get :usuario, :map => '/usuario' do
    # verificamos los permisos que tenga, y lo redirigimos a la vista de usuario
    @usuario = Usuario.get(params[:email])
  end
end
