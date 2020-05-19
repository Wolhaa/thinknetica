abc = []
3.times do
  puts "Enter the sides of the triangle!"
  abc << gets.to_f
end
  if abc.uniq.size == 1
    puts "Equilateral triangle"
    return
  end
  a, b, c = abc.sort
  if a == b && a**2 + b**2 == c**2
    puts "Triangle isosceles and rectangular"
  elsif a**2 + b**2 == c**2
    puts "Triangle rectangular"
  elsif a == b
    puts "Triangle isosceles"
  end
