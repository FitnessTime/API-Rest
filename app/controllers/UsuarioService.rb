
FitnessTimeApi::App.controllers :usuarioService do
  
  get :registrar, :map => '/registrar' do
    
    begin
      usuario = create_usuario(params)
      usuario.save
      get_sucsses_response('Usuario creado con exito.')
    rescue Exception
      get_error_response(410,'Ya existe un usuario con esta cuenta.')
    end
  end

  get :autenticar, :map => '/autenticar' do
    begin
      usuario = Usuario.get(:email => params[:email])
      usuario.is_the_same_password?(params[:pass])
      Response.get_sucesses("Todo ok maquina")
    rescue ObjectNotFoundError
      securityToken = SecurityToken.new(usuario.email,usuario.nombre,generate_random)
      Response.get_error_response(404,securityToken.to_json)
    rescue DifferentPasswordError
      Respone.get_error_response(XXX,e.message())
    end
  end

end
