class Paso
	include DataMapper::Resource
  
  	property :id, Serial

    property :pasos_dados, Float
    property :fecha, Date
  	belongs_to :usuario
end
