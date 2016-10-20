FitnessTimeApi::App.controllers :estadisticasService do
# Puede que mas adelante nos convenga "divir" el comportamiento por endidad a
# nivel objeto, pero es solo una idea.
  get :pasosDiarios , :map => '/estadisticas/pasos' do

  end

  get :kilometrosRecorridos , :map => '/estadisticas/kilometrosRecorridos' do

  end

  get :progresionDeCargas , :map => '/estadisticas/progresionDeCargas' do

  end

  get :pasosEnMeses, :map => '/pasos' do
    securityToken = SecurityToken.find_by_authToken(params[:authToken])
    if securityToken == nil
      get_error_response(404,"Usuario no autorizado.")
    else
      meses = Constantes.meses
      estadisticas = Array.new(12)
      index = 0
      meses.each do |month|
        date_a = DateTime.new Date.today.year, month.to_i, 1
        date_b = (date_a >> 1) + 1
        pasos = Paso.all(:fecha => date_a..date_b)
        cantidadPasosDelMes = 0
        if(pasos != nil)
          pasos.each do |paso|
            cantidadPasosDelMes = cantidadPasosDelMes + paso.pasos_dados          
          end
        end
        estadisticas[index] = EstadisticasPasos.new(Constantes.getMes(month.to_i), cantidadPasosDelMes)
        cantidadPasosDelMes = 0
        index = index + 1
      end
      get_success_response(estadisticas.to_json)
    end
  end

  put :kilometrosRecorridos , :map => '/estadisticas/kilometrosRecorridos' do
    securityToken = SecurityToken.first(:emailUsuario => params[:email], :authToken => params[:authToken])
    if(securityToken == nil)
      get_error_response(404, "Usuario no autenticado")
    else
      jsonKilometro = JSON.parse(params[:kilometro])
      usuario = Usuario.find_by_email(securityToken.emailUsuario)
      kilometros = Kilometro.find_by_usuario_and_fecha(usuario, jsonKilometro["fecha"])
      if(kilometros == nil)
        create_kilometros(usuario, params)
        get_success_response("")
      else
        update_kilometros(kilometros, params)
        get_success_response("")
      end
    end
  end

  get :progresionDeCargas, :map => '/marcas' do
    securityToken = SecurityToken.find_by_authToken(params[:authToken])
    if false
      get_error_response(404,"Usuario no autorizado.")
    else
      rutinas = Rutina.find_all_by_eliminada_and_usuario_email(false, securityToken.emailUsuario)
      count = get_cantidad_rutinas_con_ejercicios_con_marcas
      ret_estadisticas_marcas = Array.new(count)
      assembler = MarcaAssembler.new
      indexx = 0
      rutinas.each do |rutina|
        index = 0
        cant = get_cantidad_ejercicios_con_marcas(rutina.id)
        ret_ejercicio_marcas = Array.new(cant)
        ejercicios = Ejercicio.find_all_by_eliminada_and_type_and_rutina_id(false, 'EjercicioDeCarga', rutina.id)
        ejercicios.each do |ejercicio|
          marcas = Marca.find_all_by_ejercicio_id(ejercicio.id)
          if marcas != nil && marcas.size > 0
            marcas_dto = Array.new(marcas.size)
            i=0
            marcas.each do |marcaa|
              marcas_dto[i] = assembler.crear_dto(marcaa)
              i = i + 1
            end
            marca = EjercicioMarcas.new(ejercicio, marcas_dto)
            ret_ejercicio_marcas[index] = marca
            index = index + 1
          end
        end
        if(ret_ejercicio_marcas.size == cant)
          ret_estadisticas_marcas[indexx] = EstadisticasMarcas.new(rutina, ret_ejercicio_marcas)
          indexx = indexx + 1
        end
        
      end
      return ret_estadisticas_marcas.to_json
    end
  end
end
