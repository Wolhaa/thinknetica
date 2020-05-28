class Station
  attr_reader :name
  attr_accessor :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def train_arrival(train)
    @trains << train
  end

  def train_departure(train)
    @trains.delete(train)
  end

  def select_trains(type)
    @trains.select { |train| train.type == type }
  end
end
