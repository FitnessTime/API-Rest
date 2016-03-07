class RutinaDeAerobico
	include DataMapper::Resource

	property :id, Serial

  	property :inicio, Date
  	property :fin, Date
    property :descripcion, String
    property :aclaracion, String
    has n, :ejercicio_de_aerobicos, :through => Resource
    has n, :usuarios, :through => Resource

end
