require_relative 'manufacturer.rb'


class Wagon
  attr_reader :type

  include Manufacturer

  def initialize(type)
    @type = type
    validate!
  end

  def valid?
    validate!
    true
  rescue
    false
  end


  protected


  def validate!
    raise "Нужно указать тип вагона" if type.nil?
  end
end
