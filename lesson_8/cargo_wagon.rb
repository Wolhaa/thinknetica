# frozen_string_literal: true

class CargoWagon < Wagon
  def initialize(_type, volume, number)
    super(:cargo, volume, number)
  end
end
