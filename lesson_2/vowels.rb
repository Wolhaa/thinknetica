  hash = {}
  number = 1
  ("a".."z").each do |v|
    hash[v] = number if ["a","e","i","o","u","y"].include?(v)
    number +=1
  end
  puts hash
