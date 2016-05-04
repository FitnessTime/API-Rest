
class RutinaDTO

	attr_accessor :idWeb
    attr_accessor :idMobile
  	attr_accessor :inicio
  	attr_accessor :fin
    attr_accessor :descripcion
    attr_accessor :aclaracion
    attr_accessor :versionMobile
    attr_accessor :versionWeb
    attr_accessor :estaSincronizado
    attr_accessor :rutinaDeCarga
    attr_accessor :idUsuario

    def to_json()
        {"idWeb" => self.idWeb, "idMobile" => self.idMobile, "inicio" => self.inicio, "fin" => self.fin,
         "descripcion" => self.descripcion, "aclaracion" => self.aclaracion, "versionWeb" => self.versionWeb,
         "versionMobile" => self.versionMobile, "estaSincronizado" => self.estaSincronizado,
         "rutinaDeCarga" => self.rutinaDeCarga, "idUsuario" => self.usuario}.to_json
    end
end