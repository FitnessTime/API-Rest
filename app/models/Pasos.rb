class Pasos
  property :id, Serial , :key => true

    property :pasos_dados, Float
    property :fecha, Date
  belongs_to :usuario
end
