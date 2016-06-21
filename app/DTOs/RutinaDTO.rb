class RutinaDTO

	attr_accessor :idWeb
    attr_accessor :idMobile
  	attr_accessor :inicio
  	attr_accessor :fin
    attr_accessor :descripcion
    attr_accessor :aclaracion
    attr_accessor :inicioCambio
    attr_accessor :finCambio
    attr_accessor :descripcionCambio
    attr_accessor :aclaracionCambio
    attr_accessor :versionMobile
    attr_accessor :versionWeb
    attr_accessor :estaSincronizado
    attr_accessor :esDeCarga
    attr_accessor :eliminada
    attr_accessor :idUsuario
    attr_accessor :ejerciciosDTO

    def to_json(j)
        {"idWeb" => self.idWeb, "idMobile" => self.idMobile, "inicio" => self.inicio, "fin" => self.fin,
         "descripcion" => self.descripcion, "aclaracion" => self.aclaracion, "versionWeb" => self.versionWeb,
         "versionMobile" => self.versionMobile, "estaSincronizado" => self.estaSincronizado,
         "esDeCarga" => self.esDeCarga, "eliminada" => self.eliminada ,"idUsuario" => self.idUsuario,
         "inicioCambio" => self.inicioCambio, "finCambio" => self.finCambio,
         "aclaracionCambio" => self.aclaracionCambio, "descripcionCambio" => self.descripcionCambio,
         "ejercicios" => self.ejerciciosDTO}.to_json
     end
end