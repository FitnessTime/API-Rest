FitnessTimeApi::App.controllers :rutinaService do

  post :registrar, :map => '/crear' do
    securityToken = SecurityToken.find_by_authToken(:authToken => params[:authToken])
    if securityToken == nil
      get_error_response(413,'Usuario no autorizado.')
    end
  end

  get :rutinas, :with => :email do
      @usuario = Usuario.get([:email])
      @rutinas = @usuario.getRutinas()
      render '/rutinas/'
  end

  post :editar, :with => :rutina_id do
    @rutina = Rutina.get(params[:rutina_id])
    #falta definir el metodo actualizar_rutina
    actualizar_rutina(@rutina)
    render '/rutinas/#{@rutina.id}'
  end

  get :eliminar, :with => :rutina_id do
    @rutina = Rutina.get(params[:rutina_id])
    @rutina.destroy
    render '/rutinas'
  end

  get :consultar, :with => :rutina_id do
    @rutina = Rutina.get(params[:rutina_id])
    render '/rutinas/#{@rutina.id}'
  end

end
