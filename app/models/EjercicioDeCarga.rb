class EjercicioDeCarga
	include DataMapper::Resource

	property :id, Serial

  	property :nombre, Date
  	property :series, Date
    property :repeticiones, String
    has n, :marcas, :through => Resource
		belongs_to :rutina_de_carga

end
