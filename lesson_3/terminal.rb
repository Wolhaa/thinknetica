class Station
  attr_reader :name
  attr_accessor :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def train_arrival(train)
    @trains = train
  end

  def train_departure(train)
    @trains.delete(train)
  end

  def select_trains(type)
    @trains.select { |train| train.type == type }
  end
end

class Route
  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end

  def add_staition(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @station.delete(station)
  end

  def station_list
    @stations.each { |station| puts station.name }
  end
end

class Train
  attr_reader :number, :type, :wagons, :current_station
  attr_accessor :speed

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
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

  def add_wagons
    @wagons += 1 if speed == 0
  end

  def del_wagons
    @wagons -= 1 if speed == 0
  end

  def route=(route)
    @route = route
    @current_station = @route.stations.first
    route.first_station.train_arrival(self)
  end

  def go_next_station
    @current_station.train_departure(self)
    next_station = @route.index(@current_station) + 1
    @current_station = next_station
    @current_station.train_arrival(self)
  end

  def go_previous_station
    @current_station.train_departure(self)
    next_station = @route.index(@current_station) - 1
    @current_station = next_station
    @current_station.train_arrival(self)
  end
end
