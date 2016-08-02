class EstadisticasMarcas

	attr_accessor :rutina
	attr_accessor :ejercicioMarcas

	def initialize(rutina, ejercicioMarcas)
		@rutina = rutina
		@ejercicioMarcas = ejercicioMarcas
	end

	def to_json(a)
    {
      'rutina' => self.rutina,
      'ejercicioMarcas' => self.ejercicioMarcas
    }.to_json
  end
end