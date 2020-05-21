    puts "Enter day (dd)!"
    day = gets.chomp.to_i
    abort "Incorrect date! Try again" if day <= 0 || day > 31
    puts "Enter month (mm)!"
    month = gets.chomp.to_i
    abort "Incorrect month! Try again" if month <= 0 || month > 12
    puts "Enter year (yyyy)!"
    year = gets.chomp
    abort "Incorrect year! Try again" if year.size != 4 || year.to_i <= 0
    days_in_month = [
      31, 28, 31, 30, 31, 30,
      31, 31, 30, 31, 30, 31
    ]
    days_in_month[1] = 29 if year.to_i % 400 == 0 || (year.to_i % 4 == 0 && year.to_i % 100 != false)
    what_day = day
    days_in_month.each_with_index do |d, i|
      if i < month - 1
        what_day += d
      end
    end

    puts "Date serial number: #{what_day}!"
