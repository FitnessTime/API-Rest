class ObjectNotFoundError < RuntimeError
  def message()
    "Error, no se ecnontro el usuario"
  end
end
