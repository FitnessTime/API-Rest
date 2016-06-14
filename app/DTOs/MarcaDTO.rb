class MarcaDTO

	attr_accessor :idWeb
    attr_accessor :idMobile
    attr_accessor :fecha
    attr_accessor :carga
    attr_accessor :idEjercicio

    def to_json(j)
        {"idWeb" => self.idWeb, "idMobile" => self.idMobile, "carga" => self.carga, "fecha" => self.fecha,
         "idEjercicio" => self.idEjercicio}.to_json
     end
end