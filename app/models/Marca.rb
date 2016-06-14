class Marca
	include DataMapper::Resource

	property :id, Serial
	property :idMobile, Integer
  	property :fecha, Date
  	property :carga, Integer
  	belongs_to :ejercicio
end
