class EjercicioDeCarga
	include DataMapper::Resource

	property :id, Serial

  	property :inicio, Date
  	property :fin, Date
    property :descripcion, String
    property :aclaracion, String
    has n, :rutina_de_cargas, :through => Resource

end
