# frozen_string_literal: true

class PassengerWagon < Wagon
  def initialize(_type, volume, number)
    super(:passenger, volume, number)
  end

  def take_volume
    super(1)
  end
end
