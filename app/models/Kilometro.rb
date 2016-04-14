class Kilometro
	include DataMapper::Resource
  
  	property :id, Serial
    property :km_recorridos, Float
    property :fecha, Date
  	belongs_to :usuario
end
