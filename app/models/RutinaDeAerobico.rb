class RutinaDeAerobico
	include DataMapper::Resource

	property :id, Serial, :key => true

  	property :inicio, Date
  	property :fin, Date
    property :descripcion, String
    property :aclaracion, String
    has n, :ejercicio_de_aerobico, :through => Resource
    belongs_to :usuario

end
