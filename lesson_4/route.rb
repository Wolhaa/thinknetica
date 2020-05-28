class Route
  attr_reader :stations

  def initialize(first_station, last_station)
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
end
