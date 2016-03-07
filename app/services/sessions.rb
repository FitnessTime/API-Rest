FitnessTimeApi::App.controllers :sessions do
  
  get :login, :map => '/login' do
    @usuario = Usuario.new
    render 'sessions/nuevo'
  end

  post :create do
    email = params[:usuario][:email]
    password = params[:usuario][:password]
    @usuario = Usuario.authenticate(email, password)
    if (@usuario.nil?)
      @usuario = Usuario.new
      flash.now[:error] = 'Usuario o password invalidos'
      render 'sessions/nuevo'
    else
      sign_in @usuario
      redirect '/'          
    end
  end

  get :destroy, :map => '/logout' do 
    sign_out
    redirect '/'          
  end

end