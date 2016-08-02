class EjercicioMarcas 

	attr_accessor :ejercicio
	attr_accessor :marcas

	def initialize(ejercicio, marcas)
		@ejercicio = ejercicio
		@marcas = Array.new(marcas.size)
		i = 0
		marcas.each do |marca|
			@marcas[i] = [i.to_s, marca.carga]
			i = i +1
		end
	end

	def to_json(a)
    {
      'ejercicio' => self.ejercicio,
      'marcas' => self.marcas
    }.to_json
  end
end