Class UsuarioService < Padrino::Application

  get :registrar, :map => '/registrar' do
    usuario = UsuarioFactory.create(params)
    begin
      usuario.raise_on_save_failure()
      Response.get_sucesses('Usuario creado con exito.')
    rescue
      Response.get_error_response(410,'Ya existe un usuario con esta cuenta.')
    end
  end

  get :autenticar, :map => '/autenticar' do
    begin
      usuario = Usuario.get!(params[:email])
      usuario.is_the_same_password?(params[:pass])
      Response.get_sucesses("Todo ok maquina")
    rescue ObjectNotFoundError => e
      securityToken = SecurityToken.new(0,params[:email],"","")
      Response.get_error_response(404,securityToken.to_json)
    rescue DifferentPasswordError => e
      Respone.get_error_response(XXX,e.message())
    end
  end

end
