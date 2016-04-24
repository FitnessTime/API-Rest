FitnessTimeApi::App.helpers do

  def actualizar_rutina(rutina,params)
    update(:inicio => params[:inicio], :fin => params[:fin],
    			   :descripcion => params[:descripcion], :aclaracion => params[:aclaracion])
    # if(rutina.rutina_de_carga?)
    #   actualizar_rutina_de_carga(rutina,params)
    # else
    #   actualizar_rutina_de_aerobico(rutina,params)
    # end
  end

  def create_rutina(params)
    rutina = Rutina.new()
    rutina.inicio = params[:inicio]
  	rutina.fin = params[:fin]
    rutina.descripcion = params[:descripcion]
    rutina.aclaracion = params[:aclaracion]
    rutina.rutina_de_carga = params[:rutina_de_carga?]
    rutina.save!()
  end

  # def actualizar_rutina_de_carga(rutina,params)
  #   update(:inicio => params[:inicio], :fin => params[:fin],
  #   			   :descripcion => params[:descripcion], :aclaracion => params[:aclaracion])
  # end
  #
  # def actualizar_rutina_de_aerobico(rutina,params)
  #
  # end

end
