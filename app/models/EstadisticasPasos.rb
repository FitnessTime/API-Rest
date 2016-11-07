class EstadisticasPasos

	attr_accessor :dia
	attr_accessor :cantidad_pasos

	def initialize(dia, cantidad_pasos)
		@dia = dia
		@cantidad_pasos = cantidad_pasos
	end

	def to_json(a)
    {
      'dia' => self.dia,
      'cantidad_pasos' => self.cantidad_pasos
    }.to_json
  end
end