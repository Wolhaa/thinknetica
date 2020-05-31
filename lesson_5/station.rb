require_relative 'instance_counter.rb'


class Station
  include InstanceCounter

  attr_reader :name
  attr_accessor :trains

  @@stations

  def self.all
    @@stations
  end

  def initialize(name)
    register_instance
    @name = name
    @trains = []
    @@stations += 1
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
