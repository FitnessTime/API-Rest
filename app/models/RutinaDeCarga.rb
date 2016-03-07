class RutinaDeCarga
	include DataMapper::Resource

	property :id, Serial

  	property :inicio, Date
  	property :fin, Date
    property :descripcion, String
    property :aclaracion, String
    has n, :ejercicios_de_carga, :through => Resource

end
