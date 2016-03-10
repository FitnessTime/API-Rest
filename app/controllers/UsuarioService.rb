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
    
      usuario = Usuario.find_by_email(params[:email])
      
      if usuario == nil
        #headers['X-Forwarded-For'] = request['X-Forwarded-For']
        get_error_response(404, "No existe el usuario")
      else if usuario.is_the_same_password?(params[:pass])
            securityTokenBD = SecurityToken.first(:emailUsuario => usuario.email)
            if securityTokenBD != nil
              securityTokenBD.destroy
            end
            securityToken = SecurityToken.new(usuario.email,usuario.nombre,generate_random)
            securityToken.save
            get_sucsses_response(securityToken.to_json)
          else
            get_error_response(404, "La contrasenia es incorrecta")
      end
    end
  end

end
