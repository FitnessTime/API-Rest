FitnessTimeApi::App.helpers do

  def update_kilometros(kilometro,params)
    jsonKilometro = JSON.parse(params[:kilometro])
    kilometro.update(:km_recorridos => jsonKilometro['kms'], :fecha => jsonKilometro['fecha'])
  end

  def create_kilometros(usuario,params)
    jsonKilometro = JSON.parse(params[:kilometro])
    kilometro = Kilometro.new
    kilometro.km_recorridos = jsonKilometro['kms']
    kilometro.fecha = jsonKilometro['fecha']
    kilometro.usuario = usuario
    kilometro.save()
  end
end