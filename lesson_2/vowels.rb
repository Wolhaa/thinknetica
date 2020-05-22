  vowels = {}
  arr_vowels = ["a", "e", "i", "o", "u", "y"]

  ("a".."z").each.with_index(1) do |v, i|
    vowels[v] = i if arr_vowels.include?(v)
  end

  puts vowels
