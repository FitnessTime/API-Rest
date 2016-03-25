FitnessTimeApi::App.helpers do

  def update_usuario(usuario,params)
    pass = ::BCrypt::Password.create(params[:pass]) unless params[:pass].nil?
    usuario.update(:nombre => params[:nombre], :crypted_password => pass,
    			   :fechaNacimiento => params[:fecha], :peso => params[:peso])
  end

end