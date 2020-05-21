  cart = {}
  sum = 0
  loop do
    puts "Enter product name or stop"
    product = gets.chomp
    break if product == "stop"
    puts "Enter the price"
    price = gets.chomp.to_f
    puts "Enter the amount"
    amount = gets.chomp.to_f
    cart[product] = { price: price, amount: amount }
  end

  puts cart
  cart.each do |name, purchase|
    sum_product = purchase[:price] * purchase[:amount]
    sum += sum_product
    puts "#{name}, price: #{sum_product}"
  end

  puts "Total: #{sum}"
