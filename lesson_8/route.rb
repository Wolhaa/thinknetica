# frozen_string_literal: true

require_relative 'instance_counter.rb'
require_relative 'validation.rb'

class Route
  include InstanceCounter
  include Validation

  attr_reader :stations, :first_station, :last_station

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    validate!
    register_instance
    @stations = [first_station, last_station]
  end

  def add_staition(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end

  def station_list
    @stations.each.with_index(1) do |station, index|
      puts "#{index} - #{station.name}"
    end
  end

  protected

  def validate!
    raise 'Начальная и конечная станция не могут быть одинаковыми' if first_station == last_station
  end
end
