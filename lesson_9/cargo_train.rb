# frozen_string_literal: true

class CargoTrain < Train
  def initialize(number, _type)
    super(number, :cargo)
  end
end
