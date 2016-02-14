require 'bcrypt'

class Usuario
	include DataMapper::Resource
	
	property :id, Serial

	property :nombre, String
	property :crypted_password, String
	property :email, String
	property :fechaNacimiento, Date
	property :peso, Integer
	property :diasDeEntrenamiento, Integer, :default => 0
	property :minimoDePasosDiarios, Integer, :default => 0
	property :minimoDeKilometrosRecorridos, Integer, :default => 0
	has n, :rutina_de_cargas, :through => Resource
	has n, :rutina_de_aerobicos, :through => Resource
	has n, :estadistica

	validates_presence_of :nombre
	validates_presence_of :crypted_password
	validates_presence_of :email
	validates_presence_of :fechaNacimiento
	validates_presence_of :peso
	validates_format_of   :email, :with => :email_address

  def password= (password)
    self.crypted_password = ::BCrypt::Password.create(password) unless password.nil?	
  end

  def self.authenticate(email, password)
    user = Usuario.find_by_email(email)
    return nil if user.nil?
    user.has_password?(password)? user : nil
  end

  def has_password?(password)
    ::BCrypt::Password.new(crypted_password) == password
  end
end