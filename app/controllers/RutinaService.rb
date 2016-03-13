FitnessTimeApi::App.controllers :rutinaService do

  get :registrar, :map => '/crear' do
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

  get :editar, :with => :rutina_id do
    @rutina = Rutina.get(params[:rutina_id])
    #falta definir el metodo actualizar_rutina
    actualizar_rutina(@rutina)
    render '/rutina/#{@rutina.id}'
  end

  get :eliminar, :with => :rutina_id do
    @rutina = Rutina.get(params[:rutina_id])
    @rutina.destroy
  end

end
