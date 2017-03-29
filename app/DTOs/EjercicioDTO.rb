class EjercicioDTO

	attr_accessor :idWeb
    attr_accessor :idMobile
  	attr_accessor :nombre
  	attr_accessor :series
    attr_accessor :repeticiones
    attr_accessor :tiempoActivo
    attr_accessor :tiempoDescanso
    attr_accessor :diaDeLaSemana
    attr_accessor :estaSincronizado
    attr_accessor :versionWeb
    attr_accessor :versionMobile
    attr_accessor :esDeCarga
    attr_accessor :eliminada
    attr_accessor :nombreCambio
    attr_accessor :seriesCambio
    attr_accessor :repeticionesCambio
    attr_accessor :tiempoActivoCambio
    attr_accessor :tiempoDescansoCambio
    attr_accessor :diaDeLaSemanaCambio
    attr_accessor :idRutina
    attr_accessor :marcasDTO

    def to_json(j)
        {"idWeb" => self.idWeb, "idMobile" => self.idMobile, "nombre" => self.nombre, "series" => self.series,
         "repeticiones" => self.repeticiones, "tiempoActivo" => self.tiempoActivo, "tiempoDescanso" => self.tiempoDescanso,
         "versionWeb" => self.versionWeb, "versionMobile" => self.versionMobile, "diaDeLaSemana" => self.diaDeLaSemana,
         "estaSincronizado" => self.estaSincronizado, "esDeCarga" => self.esDeCarga, 
         "eliminada" => self.eliminada , "nombreCambio" => self.nombreCambio,
         "seriesCambio" => self.seriesCambio, "repeticionesCambio" => self.repeticionesCambio,
         "tiempoActivoCambio" => self.tiempoActivoCambio, "tiempoDescansoCambio" => self.tiempoDescansoCambio,
         "diaDeLaSemanaCambio" => self.diaDeLaSemanaCambio, "idRutina" => self.idRutina,
         "marcas" => self.marcasDTO}.to_json
    end
end