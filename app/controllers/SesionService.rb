FitnessTimeApi::App.controllers :sesionService do
  get :iniciarSesion => '/login' do
    begin
      @usuario = Usuario.get(params[:email])
      @usuario.is_the_same_password(params[:password])
      # mando el mensaje de todo OK(200) y le mando un codigo de autenticacion
      # que es el que se va validar despues a la hora de hacer las operaciones

      # Tambien tendria que hacer el render al home
    rescue ElUsuarioNoExiste
      # mando el mensaje de error en el response
    rescue LaContraseñaEsIncorrecta
      #mando el mensaje de error en el response
    end
  end

  get :cerrarSesion => '/close' do
    # aca tendria que eliminar del registro el codigo de seguridad de la sesion.
  end
end
