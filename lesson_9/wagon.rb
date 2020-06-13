# frozen_string_literal: true

require_relative 'manufacturer.rb'
require_relative 'validation.rb'

class Wagon
  include Manufacturer
  include Validation


  attr_reader :type, :volume, :number
  attr_accessor :occupied_volume
  validate :type, :presence

  def initialize(type, volume, number)
    @number = number
    @type = type
    @volume = volume
    @occupied_volume = 0
    validate!
  end

  def take_volume(quantity)
    raise 'Недостаточно места в этом вагоне' if @occupied_volume + quantity > @volume

    @occupied_volume += quantity
  end

  def free_volume
    @volume - @occupied_volume
  end
end
