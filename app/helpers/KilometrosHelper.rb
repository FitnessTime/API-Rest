FitnessTimeApi::App.helpers do

  def update_kilometros(jsonKilometros)
    kilometro = Kilometro.find_by_id(jsonKilometros['id'])
    kilometro.update(:km_recorridos => jsonKilometro['kms'], :fecha => jsonKilometro['fecha'])
  end

  def create_kilometros(jsonKilometros)
    usuario = Usuario.find_by_email(jsonKilometros['idUsuario'])
    kilometro = Kilometro.new
    kilometro.km_recorridos = jsonKilometro['kms']
    kilometro.fecha = jsonKilometro['fecha']
    kilometro.usuario = usuario
    kilometro.save()
    return kilometro
  end
end