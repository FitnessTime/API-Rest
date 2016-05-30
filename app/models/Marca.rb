class Marca
	include DataMapper::Resource

	property :id, Serial
  	property :fecha, Date
  	property :carga, Integer
  	belongs_to :ejercicio
end
