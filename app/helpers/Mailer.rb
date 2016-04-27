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
end