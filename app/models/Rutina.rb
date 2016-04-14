class Rutina
	include DataMapper::Resource

	property :id, Serial, :key => true

  	property :inicio, Date
  	property :fin, Date
    property :descripcion, String
    property :aclaracion, String
    property :version, Integer
    property :estaSincronizado, Boolean
    property :rutinaDeCarga, Boolean
    has n, :ejercicios, :through => Resource
    belongs_to :usuario

end
