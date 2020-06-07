class PassengerWagon < Wagon
  def initialize(type,volume, number)
    super(:passenger, volume, number)
  end

  def take_volume
    super(1)
  end
end
