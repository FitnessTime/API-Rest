class Hito
	include DataMapper::Resource
	
	property :id, Serial

  	property :fecha, Date
  	property :carga, Integer
  	belongs_to :ejercicioDeCarga
end