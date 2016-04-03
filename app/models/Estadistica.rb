class Estadistica
	include DataMapper::Resource

	property :id, Serial

  	property :registroDePasos, Integer
		# tendria que ser decimal el de los km
  	property :registroDeKilometrosRecorridos, Integer
		# el tema de las estadisticas de progresion de cargas como hacemos? solo de
		# consulta sin persistencia? o las persistimos?
  	belongs_to :usuario
end
