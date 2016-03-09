class Marca
	include DataMapper::Resource

	property :id, Serial, :key => true

  	property :fecha, Date
  	property :carga, Integer
end
