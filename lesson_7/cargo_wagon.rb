class CargoWagon < Wagon
  def initialize(type,volume, number)
    super(:cargo, volume, number)
  end
end
