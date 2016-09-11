require_relative '../Assemblers/MarcaAssembler.rb'

FitnessTimeApi::App.controllers :marcaService do
  
  post :registrarMarca, :map => '/marcas' do
    securityToken = SecurityToken.find_by_authToken(params[:authToken])
    if securityToken == nil
      get_error_response(404,"Usuario no autorizado.")
    else
      jsonMarca = JSON.parse(params[:marca])
      ejercicio = EjercicioDeCarga.find_by_id(jsonMarca['idEjercicio'])
      marca = create_marca(jsonMarca, ejercicio)
      get_success_response("")
    end
  end

  get :marcas, :map => '/marcas' do
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
