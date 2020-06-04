require_relative 'instance_counter.rb'
require_relative 'validation.rb'


class Station
  include InstanceCounter
  include Validation


  attr_reader :name
  attr_accessor :trains

  @@stations = 0

  def self.all
    @@stations
  end

  def initialize(name)
    register_instance
    @name = name
    validate!
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


  protected

  def validate!
    raise "Не указано название станции" if name.nil?
  end
end
