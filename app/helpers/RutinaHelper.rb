FitnessTimeApi::App.helpers do

  def actualizar_rutina(rutina,params)
    # Podriamos unificar las dos rutinas en una unica clase, estoy viendo que es
    # al pedo tenerlas dividas
    if(rutina.rutina_de_carga?)
      actualizar_rutina_de_carga(rutina,params)
    else
      actualizar_rutina_de_aerobico(rutina,params)
    end
  end

end
