class DifferentPasswordError < RuntimeError
  def message()
    return("El password es incorrecto")
  end
end
