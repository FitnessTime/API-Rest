# class RutinaDeCarga
# 	include DataMapper::Resource
#
# 	property :id, Serial, :key => true
#
#   	property :inicio, Date
#   	property :fin, Date
#     property :descripcion, String
#     property :aclaracion, String
#     property :version, Integer
#     property :estaSincronizado, Boolean
#     has n, :ejercicio_de_cargas, :through => Resource
#     belongs_to :usuario
#
# end
