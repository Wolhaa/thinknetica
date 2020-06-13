# frozen_string_literal: true

class PassengerTrain < Train
  def initialize(number, _type)
    super(number, :passenger)
  end
end
