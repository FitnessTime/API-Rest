class EjercicioDeCarga
	include DataMapper::Resource

	property :id, Serial, :key => true

  	property :nombre, String
  	property :series, Integer
    property :repeticiones, Integer
    has n, :marcas, :through => Resource
	belongs_to :rutina_de_carga

end
