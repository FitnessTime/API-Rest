

FitnessTimeApi::App.controllers :usuarios do

  get :registrar, :map => '/registrar' do
    usuario = Usuario.new
    usuario.nombre = params[:nombre]
    usuario.password = (params[:pass])
    usuario.fechaNacimiento = params[:fecha]
    usuario.peso = params[:peso]
    usuario.email = params[:email]
    if usuario.save
      Response.get_sucsses_response('Usuario creado con exito.')
    else
      Response.get_error_response('No se pudo registrar el usuario.')
    end
  end

  get :autenticar, :map => '/autenticar' do
    usuario = Usuario.authenticate(params[:email], params[:pass])
    
    if usuario==nil
      #headers['X-Forwarded-For'] = request['X-Forwarded-For']
      securityToken = SecurityToken.new(0,params[:email],"","")
      Response.get_error_response(securityToken.to_json)      
    else
      range = RandomAlphanumericHelper.generate()
      securityTokenBD = SecurityToken.first(:idUsuario => usuario.id)
      securityToken = SecurityToken.new(usuario.id,usuario.nombre,usuario.email,range)
      if securityTokenBD != nil
        securityTokenBD.destroy
      end
      securityToken.save
      Response.get_sucsses_response(securityToken.to_json,{'content-Type'=>'text/plain'})
    end
  end

end