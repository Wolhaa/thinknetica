class PassengerTrain < Train
  def initialize(number, type)
    super(number, :passenger)
  end
end
