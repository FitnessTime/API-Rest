require_relative '../Assemblers/EjercicioAssembler.rb'


FitnessTimeApi::App.controllers :ejercicioService do

  post :registrarEjercicio, :map => '/ejercicios' do
    securityToken = SecurityToken.find_by_authToken(params[:authToken])
    if securityToken == nil
      get_error_response(404,"Usuario no autorizado.")
    else
      begin
        jsonEjercicio = JSON.parse(params[:ejercicio])
      rutina = Rutina.find_by_id(jsonEjercicio['idRutina'])
      ejercicio = crear_ejercicio(jsonEjercicio, rutina)
      assembler = EjercicioAssembler.new
      ejercicioDTO = assembler.crear_dto(ejercicio, rutina.esDeCarga)
      get_success_response(ejercicioDTO.to_json(''))
      rescue DataMapper::SaveFailureError
        get_error_response(404,'No se pudo crear el ejercicio')
      end
    end
  end

  get :ejercicios, :map => '/ejercicios' do
    securityToken = SecurityToken.find_by_authToken(params[:authToken])
    if securityToken == nil
      get_error_response(404,"Usuario no autorizado.")
    else
      get_success_response(retornar_ejercicios_dto(securityToken).to_json)
    end
  end

  put :modificarEjercicio, :map => '/ejercicios' do
    securityToken = SecurityToken.find_by_authToken(params[:authToken])
    if securityToken == nil
      get_error_response(404,"Usuario no autorizado.")
    else
      jsonEjercicio = JSON.parse(params[:ejercicio])
      ejercicio_actualizado = actualizar_ejercicio(jsonEjercicio)
      assembler = EjercicioAssembler.new
      ejercicioDTO = assembler.crear_dto(ejercicio_actualizado, jsonEjercicio['esDeCarga'])
      get_success_response(ejercicioDTO.to_json(''))
    end
  end

  delete :eliminar, :map => '/ejercicios' do
    securityToken = SecurityToken.find_by_authToken(params[:authToken])
    if securityToken == nil
      get_error_response(404,"Usuario no autorizado.")
    else
      if(params[:esDeCarga])
        ejercicio = EjercicioDeCarga.find_by_id(params[:id])
      else
        ejercicio = EjercicioDeAerobico.find_by_id(params[:id])
      end
      ejercicio.update(:eliminada => true, :estaSincronizado => true)
      assembler = EjercicioAssembler.new
      ejercicioDTO = assembler.crear_dto(ejercicio, params[:esDeCarga])
      get_success_response(ejercicioDTO.to_json(''))
    end
  end
end
