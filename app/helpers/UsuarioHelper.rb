FitnessTimeApi::App.helpers do

  def update_usuario(usuario,params)
    pass = ::BCrypt::Password.create(params[:pass]) unless params[:pass].nil?
    usuario.update(:nombre => params[:nombre], :crypted_password => pass,
    			   :fechaNacimiento => params[:fecha], :peso => params[:peso])
  end

  def create_usuario(params)
    usuario = Usuario.new
    usuario.nombre = params[:nombre]
    usuario.password = params[:pass]
    usuario.fechaNacimiento = params[:fecha]
    usuario.peso = params[:peso]
    usuario.email = params[:email]
    return usuario
  end

end
