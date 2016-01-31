

FitnessTimeApi::App.controllers :usuarios do

  get :registrar, :map => '/registrar' do
    usuario = Usuario.new
    usuario.nombre = params[:nombre]
    usuario.password = (params[:pass])
    usuario.fechaNacimiento = params[:fecha]
    usuario.peso = params[:peso]
    usuario.email = params[:email]
    if usuario.save
      Response.get_sucsses()
    else
      Response.get_error()
    end
  end

  get :autenticar, :map => '/autenticar' do
    usuario = Usuario.authenticate(params[:email], params[:pass])
    
    if usuario==nil
      #headers['X-Forwarded-For'] = request['X-Forwarded-For']
      securityToken = SecurityToken.new(0,params[:email],"","")
      Response.get_error_response(securityToken.to_json)      
    else
      range = Array.new(25){[*"A".."Z", *"0".."9", *"a".."z"].sample}.join
      securityToken = SecurityToken.new(usuario.id,usuario.nombre,usuario.email,range)
      securityToken.save
      Response.get_sucsses_response(securityToken.to_json,{'content-Type'=>'text/plain'})
    end
  end

end