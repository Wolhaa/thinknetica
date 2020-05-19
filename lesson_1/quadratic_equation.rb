abc = []
3.times do
  puts "Enter coefficient"
  abc << gets.to_f
end
a, b, c = abc
d = b**2 - 4*a*c
if d > 0
  d_root = Math.sqrt(d)
  x1 = (-b + d_root) / (2 * a)
  x2 = (-b - d_root) / (2 * a)
  puts "Discriminant: d = #{d}, roots: x1 = #{x1}, x2 = #{x2}"
elsif d == 0
  x = -b / (2 * a)
  puts "Discriminant d = #{d}, root: x = #{x}"
else
  puts "No roots"
end
