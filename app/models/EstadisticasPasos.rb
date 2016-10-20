class EstadisticasPasos

	attr_accessor :mes
	attr_accessor :cantidad_pasos

	def initialize(mes, cantidad_pasos)
		@mes = mes
		@cantidad_pasos = cantidad_pasos
	end

	def to_json(a)
    {
      'mes' => self.mes,
      'cantidad_pasos' => self.cantidad_pasos
    }.to_json
  end
end