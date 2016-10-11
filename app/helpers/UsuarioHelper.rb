FitnessTimeApi::App.helpers do

  def update_usuario(usuario,jsonUsuario)

    usuario.update(:nombre => jsonUsuario['nombre'], :fechaNacimiento => jsonUsuario['fecha'], 
                   :peso => jsonUsuario['peso'], :minimoDePasosDiarios => jsonUsuario['cantidadMinimaPasos'])
    return usuario
  end

  def cambiar_contrasenia(params)
      usuario = Usuario.find_by_email(params[:email])
      pass = ::BCrypt::Password.create(params[:nuevaPass]) unless params[:nuevaPass].nil?
      usuario.update(:crypted_password => pass)
      return usuario
  end

  def create_usuario(params)
    jsonUsuario = JSON.parse(params[:usuario])
    usuario = Usuario.new
    usuario.nombre = jsonUsuario['nombre']
    usuario.password = jsonUsuario['password']
    usuario.fechaNacimiento = jsonUsuario['fecha']
    usuario.peso = jsonUsuario['peso']
    usuario.email = jsonUsuario['email']
    usuario.minimoDePasosDiarios = jsonUsuario['cantidadMinimaPasos']
    return usuario
  end
end
