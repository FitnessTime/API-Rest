FitnessTimeApi::App.helpers do

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
