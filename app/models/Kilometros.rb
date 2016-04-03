class kilometros
  property :id, Serial , :key => true

    property :km_recorridos, Float
    property :fecha, Date , key => true
  belongs_to :usuario
end
