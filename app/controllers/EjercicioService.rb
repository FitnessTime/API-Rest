require_relative '../Assemblers/EjercicioAssembler.rb'

FitnessTimeApi::App.controllers :ejercicioService do

  post :registrarEjercicio, :map => '/ejercicios' do
    securityToken = SecurityToken.find_by_authToken(params[:authToken])
    if securityToken == nil
      get_error_response(404,"Usuario no autorizado.")
    else
      jsonEjercicio = JSON.parse(params[:ejercicio])
      ejercicio = create_ejercicio(jsonEjercicio)
    end
  end

  get :ejercicios, :map => '/ejercicios' do
    securityToken = SecurityToken.find_by_authToken(params[:authToken])
    if securityToken == nil
      get_error_response(404,"Usuario no autorizado.")
    else
      get_success_response("Ok")
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
    @rutina = Rutina.get(params[:idEjercicio])
    @rutina.destroy()
    securityToken = SecurityToken.find_by_authToken(params[:authToken])
    if securityToken == nil
      get_error_response(404,"Usuario no autorizado.")
    else
      ejercicio = Ejercicio.find_by_id(params[:id])
      ejercicio.update(:eliminada => true, :estaSincronizado => true)
      assembler = EjercicioAssembler.new
      ejercicioDTO = assembler.crear_dto(ejercicio,params[:esDeCarga])
      get_success_response(ejercicioDTO.to_json(''))
    end
  end
end
