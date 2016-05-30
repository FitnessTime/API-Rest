class Rutina
	include DataMapper::Resource

	property :id, Serial
    property :idMobile, Integer
  	property :inicio, Date
  	property :fin, Date
    property :descripcion, String
    property :aclaracion, String
    property :version, Integer , :default => 0
    property :versionMobile, Integer , :default => 0
    property :estaSincronizado, Boolean, :default => false
    property :esDeCarga, Boolean
    property :eliminada, Boolean
    property :inicioCambio, Boolean, :default => false
    property :finCambio, Boolean, :default => false
    property :descripcionCambio, Boolean, :default => false
    property :aclaracionCambio, Boolean, :default => false
    has n, :ejercicios
    belongs_to :usuario

end
