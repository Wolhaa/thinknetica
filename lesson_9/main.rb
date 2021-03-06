# frozen_string_literal: true

require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'train.rb'
require_relative 'wagon.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_train.rb'
require_relative 'passenger_wagon.rb'
require_relative 'cargo_wagon.rb'
require_relative 'manufacturer.rb'
require_relative 'instance_counter.rb'
require_relative 'acсessors.rb'
require_relative 'validation.rb'


class RailRoad
  def initialize
    @trains = []
    @routes = []
    @stations = []
    @wagons = {}
    @id_wagon = 0
  end

  def menu
    options = {
      1 => 'Создать станции', 2 => 'Создать поезда', 3 => 'Создать маршрут и управлять станциями в нем',
      4 => 'Назначить маршрут поезду', 5 => 'Добавить вагоны к поезду', 6 => 'Отцеплять вагоны от поезда',
      7 => 'Перемещать поезд по маршруту вперед и назад', 8 => 'Загрузка тестовых данных',
      9 => 'Просматривать список станций и список поездов на станции', 0 => 'Выход из меню'
    }
    puts 'Добро пожаловать в меню управления ж/д станцией'
    puts 'Выберите действие'

    options.each do |number, option|
      puts "#{number}: #{option}"
    end

    option = gets.chomp

    loop do
      case option
      when '1'
        add_staition
      when '2'
        add_train
      when '3'
        routes_menu
      when '4'
        train_route
      when '5'
        add_wagons_to_train
      when '6'
        del_wagons_to_train
      when '7'
        moving_train
      when '8'
        seed
      when '9'
        review
      when '0'
        abort 'Спасибо за внимание!'
      end
    end
  end

  private

  def add_staition
    loop do
      puts 'Введите название станции! или нажмите 0 -(Возврат в главное меню)'
      name_staition = gets.chomp
      if name_staition == '0' && @stations.size >= 2
        break
      elsif name_staition == '0' && @stations.size < 2
        puts 'Надо создать минимум 2 станции!'
        redo
      else
        station = Station.new(name_staition)
        @stations << station
      end
    end
    menu
  end

  def add_train
    loop do
      puts 'Введите номер нового поезда'
      train_number = gets.chomp
      puts 'Нажмите 1 - для пассажирского поезда или 2 - для грузового'
      train_type = gets.chomp
      if train_type == '1'
        begin
          train = PassengerTrain.new(train_number, train_type)
        rescue StandardError
          redo
        end
        @trains << train
        puts "Создан пассажирский поезд №#{train.number}"
        menu
      elsif train_type == '2'
        begin
          train = CargoTrain.new(train_number, train_type)
        rescue StandardError
          redo
        end
        @trains << train
        puts "Создан грузовой поезд №#{train.number}"
        menu
      else
        puts 'Возврат в главное меню!'
        menu
      end
    end
  end

  def routes_menu
    puts 'Выберите действие!'
    options = {
      1 => 'Создать новый маршрут', 2 => 'Добавить станцию в маршрут',
      3 => 'Удалить станцию из маршрута', 0 => 'Возврат в главное меню'
    }
    options.each do |number, option|
      puts "#{number}: #{option}"
    end

    option = gets.chomp

    loop do
      case option
      when '1'
        add_new_route
      when '2'
        choice_route
        route_index = gets.chomp.to_i
        route = @routes[route_index - 1]
        station_to_route(route)
      when '3'
        choice_route
        route_index = gets.chomp.to_i
        route = @routes[route_index - 1]
        station_from_route(route)
      when '0'
        break
      end
    end
    menu
  end

  def add_new_route
    if @stations.size.zero?
      puts 'Сначала создайте станции!'
      menu
    end
    puts 'Выберите номер первой станции маршрута из списка:'
    show_stations
    station_index = gets.chomp.to_i
    first_station = @stations[station_index - 1]
    puts 'Выберите номер последней станции маршрута из списка:'
    show_stations
    station_index = gets.chomp.to_i
    last_station = @stations[station_index - 1]
    route = Route.new(first_station, last_station)
    @routes << route
    station_to_route(route)
  end

  def station_to_route(route)
    puts 'Выберите номер станции, которую хотите добавить или 0 - для возврата в меню станций'
    show_stations
    station_index = gets.chomp.to_i
    if station_index.zero?
      routes_menu
    else
      selected_station = @stations[station_index - 1]
      route.add_staition(selected_station)
      route.station_list
      routes_menu
    end
  end

  def station_from_route(route)
    puts 'Выберите номер станции, которую хотите удалить или 0 - для возврата в меню станций'
    route.station_list
    station_index = gets.chomp.to_i
    if station_index.zero?
      routes_menu
    else
      selected_station = @stations[station_index - 1]
      route.delete_station(selected_station)
      route.station_list
      routes_menu
    end
  end

  def train_route
    if @trains.empty?
      puts 'Сначала добавьте поезд'
      menu
    elsif @routes.empty?
      puts 'Сначала добавьте маршрут'
      menu
    else
      choice_train
      train_index = gets.chomp.to_i
      train = @trains[train_index - 1]
      choice_route
      route_index = gets.chomp.to_i
      route = @routes[route_index - 1]
      train.route = route
      menu
    end
  end

  def add_wagons_to_train
    if @trains.empty?
      puts 'Сначала добавьте поезд'
      menu
    else
      choice_train
      train_index = gets.chomp.to_i
      train = @trains[train_index - 1]
      if train.type == :cargo
        puts 'Введите объем грузового вагона'
        cargo_volume = gets.to_i
        @id_wagon += 1
        wagon = CargoWagon.new(:cargo, cargo_volume, @id_wagon)
        @wagons[@id_wagon] = wagon
      else
        puts 'Введите количество мест в пассажирском вагоне'
        pass_volume = gets.to_i
        @id_wagon += 1
        wagon = PassengerWagon.new(:passenger, pass_volume, @id_wagon)
        @wagons[@id_wagon] = wagon
      end
      train.add_wagons(wagon)
      puts 'Вагон добавлен!'
      wagons_menu
    end
  end

  def del_wagons_to_train
    if @trains.empty?
      puts 'Сначала добавьте поезд'
      menu
    else
      choice_train
      train_index = gets.chomp.to_i
      train = @trains[train_index - 1]
      if train.wagons.empty?
        puts 'Сначала добавьте вагоны к этому поезду'
        menu
      else
        wagon = train.wagons.last
        train.del_wagons(wagon)
        puts 'Вагон отцеплен!'
        menu
      end
    end
  end

  def moving_train
    if @trains.empty?
      puts 'Сначала создайте поезд'
    else
      choice_train
      train_index = gets.chomp.to_i
      train = @trains[train_index - 1]
      moving_menu(train)
    end
  end

  def moving_menu(train)
    puts 'Выберите куда переместить поезд: 1 - Вперед, 2 - Назад'
    loop do
      choice = gets.chomp
      if choice == '1'
        train.go_next_station
        menu
      elsif choice == '2'
        train.go_previous_station
        menu
      else
        puts 'Неправильное значение, попробуйте еще раз'
        break
      end
    end
  end

  def wagons_menu
    options = {
      1 => 'Добавить вагон к поезду',
      2 => 'Управление посадкой или загрузкой вагона',
      0 => 'Возврат в главное меню'
    }
    options.each do |number, option|
      puts "#{number}: #{option}"
    end

    option = gets.chomp

    loop do
      case option
      when '1'
        add_wagons_to_train
      when '2'
        loading
      when '0'
        break
      end
    end
    menu
  end

  def loading
    puts 'Введите номер вагона из списка'
    show_wagons
    wagon_number = gets.chomp.to_i
    wagon = @wagons[wagon_number]
    if wagon.type == :passenger
      wagon.take_volume(1)
      puts 'Произведена посадка одного человека'
      puts "Свободных мест: #{wagon.free_volume}"
      wagons_menu
    else
      puts 'Введите количество для погрузки'
      cargo = gets.chomp.to_i
      if cargo > wagon.free_volume
        puts 'Не хватает места в этом вагоне'
      else
        wagon.take_volume(cargo)
        puts 'Произведена загрузка вагона'
        puts "Свободных объема: #{wagon.free_volume}"
        wagons_menu
      end
    end
  end

  def show_wagons
    @wagons.each do |number, wagon|
      puts "#{number}: - тип:#{wagon.type} объем:#{wagon.volume} занято:#{wagon.occupied_volume}"
    end
  end

  def show_stations
    @stations.each.with_index(1) do |st, i|
      puts "#{i} - #{st.name}"
    end
  end

  def choice_route
    puts 'Выберите номер маршрута'
    @routes.each.with_index(1) do |route, index|
      puts "Маршрут № #{index}"
      route.station_list
    end
  end

  def choice_train
    puts 'Выберите поезд из списка'
    @trains.each.with_index(1) do |train, index|
      puts "#{index}: Поезд №#{train.number}, тип: #{train.type}"
    end
  end

  def review
    puts 'Просмотр станций и поездов на них'
    @stations.each do |station|
      puts "Станция: #{station.name}"
      station.each_train do |train|
        puts "Поезд: #{train.number}, тип: #{train.type}, вагонов: #{train.wagons.size}"
        train.each_wagon do |wagon|
          puts "Вагон: #{wagon.number}, тип: #{wagon.type}, занято: #{wagon.free_volume}, свободно: #{wagon.occupied_volume}"
        end
      end
    end
    menu
  end

  def seed
    @stations = []
    @trains = []

    @stations.push(Station.new('Новороссийск'))
    @stations.push(Station.new('Москва'))
    @stations.push(Station.new('Сочи'))
    @stations.push(Station.new('Темрюк'))
    @stations.push(Station.new('Анапа'))
    @stations.push(Station.new('Крымск'))
    @stations.push(Station.new('Адлер'))

    train1 = PassengerTrain.new('пас-01', '1')
    @trains.push(train1)
    @trains.push(PassengerTrain.new('пас-02', '1'))
    @trains.push(PassengerTrain.new('пас-03', '1'))
    @trains.push(PassengerTrain.new('пас-04', '1'))

    train2 = CargoTrain.new('грз-01', '2')
    @trains.push(train2)
    @trains.push(CargoTrain.new('грз-02', '2'))
    @trains.push(CargoTrain.new('грз-03', '2'))
    @trains.push(CargoTrain.new('грз-04', '2'))
    puts 'Данные успешно очищены и созданы'
    menu
  rescue StandardError => e
    puts e.message
    menu
  end
end

menu = RailRoad.new
menu.menu
