  fib = [0, 1]
  next_fib = fib.last
  while next_fib < 100
    next_fib = fib[-1] + fib[-2]
    fib << next_fib if next_fib < 100
  end

  puts fib
