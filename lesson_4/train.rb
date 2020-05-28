class Train
  attr_reader :number, :type, :wagons, :current_station, :route
  attr_accessor :speed

  def initialize(number, type)
    @number = number
    @type = type
    @wagons = []
    @speed = 0
  end

  def increase_speed(speed)
    @speed += speed
  end

  def current_speed
    puts @speed
  end

  def decrease_speed(speed)
    @speed -= speed
    @speed = 0 if @speed < 0
  end

  def show_wagons
    puts @wagons
  end

  def add_wagons(wagon)
    @wagons.push(wagon) if speed == 0 && type == wagon.type
  end

  def del_wagons(wagon)
    @wagons.delete(wagon) if speed == 0 && @wagons.size != 0
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
end
