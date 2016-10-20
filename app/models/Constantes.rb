class Constantes

	def self.securityKey()
		"fas5468eg4rg321"
	end

	def self.meses()
		meses = Array.new(12)
      	meses[0] = 1 
      	meses[1] = 2 
      	meses[2] = 3 
      	meses[3] = 4 
      	meses[4] = 5 
      	meses[5] = 6 
      	meses[6] = 7 
      	meses[7] = 8 
      	meses[8] = 9 
      	meses[9] = 10 
      	meses[10] = 11
      	meses[11] = 12
      	meses
	end

	def self.getMes(numeroMes)
		if(numeroMes == 1)
			return "Enero"
		elsif (numeroMes == 2)
			return "Febrero"
		elsif (numeroMes == 3)		
			return "Marzo"
		elsif (numeroMes == 4)		
			return "Abril"
		elsif (numeroMes == 5)		
			return "Mayo"
		elsif (numeroMes == 6)		
			return "Junio"
		elsif (numeroMes == 7)		
			return "Julio"
		elsif (numeroMes == 8)		
			return "Agosto"
		elsif (numeroMes == 9)		
			return "Septiembre"
		elsif (numeroMes == 10)		
			return "Octubre"
		elsif (numeroMes == 11)		
			return "Noviembre"
		end
		return "Diciembre"
	end
end