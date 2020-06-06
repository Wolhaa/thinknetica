class PassengerWagon < Wagon
  def initialize(type,volume, number)
    super(:passenger, volume, number)
  end
end
