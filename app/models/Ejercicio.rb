
class Ejercicio
	include DataMapper::Resource

	property :id, Serial
	property :type, Discriminator, :key => true
  	property :nombre, String
  	property :series, Integer
  	property :diaDeLaSemana, String
	belongs_to :rutina
end