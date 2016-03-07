class DifferentPasswordError < RuntimeError
  def message()
    "Error, el password es incorrecto."
  end
end
