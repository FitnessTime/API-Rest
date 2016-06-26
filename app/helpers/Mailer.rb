FitnessTimeApi::App.helpers do

	def enviar_mail_bienvenida(to, usuario, contrasenia)
		begin
		email(:from => "FitnessTime", :to => to, :subject => "Bienvenido a FitnessTime",
		 	  :body=>"Gracias por elegir fitness time.

		 	  		  Su nuevo usuario es: " + usuario + "
		 	  		  " +
		 	  		  "Su password es: " + contrasenia)
		rescue Exception
		end
	end

	def enviar_mail_cambio_contrasenia(to, contrasenia)
		begin
		email(:from => "FitnessTime", :to => to, :subject => "Cambio password.",
		 	  :body=>"Su nuevo password es: " + contrasenia
		rescue Exception
		end
	end
end