FitnessTimeApi::App.controllers :usuarioService do
  #  Para que iba el :map?
  post :registrarUsuario => '/registrarUsuario' do
    begin
      usuario = create_usuario(params)
      usuario.save
      enviar_mail_bienvenida(usuario.email, usuario.email, params[:pass])
      get_sucsses_response('Usuario creado con exito.')
    rescue ElUsuarioYaExiste
      get_error_response(410,'Ya existe un usuario con esta cuenta.')
    end
  end

  get :modificarUsuario => '/modificarUsuario' do
    # antes de arrancar con la modificacion hay que validar que tiene permisos
    # para hacerlo con el codigo de autenticacion
    @usuario = Usuario.get(params[:email])
    update_usuario(@usuario,params)
    @usuario.save
    # tendriamos que redirigir a algun lado?
  end

  get :eliminarCuenta => '/eliminarCuenta' do
    #validamos que pueda realizar la operaciones
    Usuario.destroy(params[:email])
    # cerramos la sesion eliminando el codigo de autenticacion.

    # mandamos en el response el mensaje de que esta todo ok
  end

  get :usuario => '/usuario' do
    # verificamos los permisos que tenga, y lo redirigimos a la vista de usuario
    @usuario = Usuario.get(params[:email])
  end
end
