  puts "Enter day (dd)!"
  day = gets.chomp.to_i
  abort "Incorrect date! Try again" if day <= 0 || day > 31

  puts "Enter month (mm)!"
  month = gets.chomp.to_i
  abort "Incorrect month! Try again" if month <= 0 || month > 12

  puts "Enter year (yyyy)!"
  year = gets.chomp.to_i
  abort "Incorrect year! Try again" if year <= 0

  days_in_month = [
    31, 28, 31, 30, 31, 30,
    31, 31, 30, 31, 30, 31
    ]

  days_in_month[1] = 29 if year % 400 == 0 || (year % 4 == 0 && year % 100 != 0)
  what_day = days_in_month.first(month - 1).sum(day)
  puts "Date serial number: #{what_day}!"
