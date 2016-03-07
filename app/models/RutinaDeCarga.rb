class RutinaDeCarga
	include DataMapper::Resource

	property :id, Serial

  	property :inicio, Date
  	property :fin, Date
    property :descripcion, String
    property :aclaracion, String
    has n, :ejercicio_de_cargas, :through => Resource
    has n, :usuarios, :through => Resource

end
