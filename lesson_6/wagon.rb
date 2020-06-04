require_relative 'manufacturer.rb'
require_relative 'validation.rb'


class Wagon
  attr_reader :type

  include Manufacturer
  include Validation

  def initialize(type)
    @type = type
    validate!
  end


  protected


  def validate!
    raise "Нужно указать тип вагона" if type.nil?
  end
end
