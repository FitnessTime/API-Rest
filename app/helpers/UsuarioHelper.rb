FitnessTimeApi::App.helpers do

  def update_usuario(usuario,params)
    pass = ::BCrypt::Password.create(params[:pass]) unless params[:pass].nil?
    usuario.update(:nombre => params[:nombre], :crypted_password => pass,
    			   :fechaNacimiento => params[:fecha], :peso => params[:peso])
  end

  def create_usuario(params)
    jsonUsuario = JSON.parse(params[:usuario])
    usuario = Usuario.new
    usuario.nombre = jsonUsuario['nombre']
    usuario.password = jsonUsuario['password']
    usuario.fechaNacimiento = jsonUsuario['fecha']
    usuario.peso = jsonUsuario['peso']
    usuario.email = jsonUsuario['email']
    return usuario
  end
end
