class DifferentPasswordError < RutinmeError
  def message()
    return("El password es incorrecto")
  end
end
