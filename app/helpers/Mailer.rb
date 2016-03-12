FitnessTimeApi::App.helpers do

	def enviar_mail_bienvenida(to, usuario, contrasenia)
		email(:from => "api.fitnesstime", :to => to, :subject => "Bienvenido a FitnessTime",
		 	  :body=>"Gracias por elegir fitness time.

		 	  		  Su nuevo usuario es: " + usuario + "
		 	  		  " +
		 	  		  "Su password es: " + contrasenia)
	end
end