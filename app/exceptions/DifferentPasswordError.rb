class DifferentPasswordError < RuntinmeError
  def message()
    return("El password es incorrecto")
  end
end
