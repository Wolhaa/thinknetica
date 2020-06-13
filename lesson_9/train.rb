# frozen_string_literal: true

require_relative 'acсessors.rb'
require_relative 'manufacturer.rb'
require_relative 'instance_counter.rb'
require_relative 'validation.rb'

class Train
  include InstanceCounter
  include Manufacturer
  include Validation
  extend Acсessors

  NUMBER_FORMAT = /^[а-яa-z0-9]{3}-?[а-яa-z0-9]{2}$/i.freeze

  attr_reader :number, :type, :wagons, :current_station, :route
  attr_accessor :speed
  attr_accessor_with_history :drive
  strong_attr_accessor :speed_limit, Integer
  validate :number, :format, NUMBER_FORMAT

  @@trains = {}

  def initialize(number, type)
    register_instance
    @number = number
    @type = type
    @wagons = []
    @speed = 0
    validate!
    @@trains[number] = self
  end

  def increase_speed(speed)
    @speed += speed
  end

  def current_speed
    puts @speed
  end

  def decrease_speed(speed)
    @speed -= speed
    @speed = 0 if @speed.negative?
  end

  def show_wagons
    puts @wagons
  end

  def add_wagons(wagon)
    @wagons.push(wagon) if speed.zero? && type == wagon.type
  end

  def del_wagons(wagon)
    @wagons.delete(wagon) if speed.zero? && !@wagons.empty?
  end

  def select_wagons
    @wagons.select { |wagon| wagon.type == type }
  end

  def route=(route)
    @route = route
    @current_station = @route.stations.first
    @current_station&.train_arrival(self)
    puts "Текущая станция: #{@current_station.name}"
  end

  def go_next_station
    @current_station&.train_departure(self)
    next_station = @route.stations.index(@current_station) + 1
    @current_station = @route.stations[next_station]
    @current_station&.train_arrival(self)
    puts "Текущая станция: #{@current_station.name}"
  end

  def go_previous_station
    @current_station&.train_departure(self)
    next_station = @route.stations.index(@current_station) - 1
    @current_station = @route.stations[next_station]
    @current_station&.train_arrival(self)
    puts "Текущая станция: #{@current_station.name}"
  end

  def self.find(number)
    @@trains[number]
  end

  def each_wagon
    @wagons.each { |wagon| yield wagon }
  end
end
