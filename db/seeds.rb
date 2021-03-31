Product.create(name: "CPU", description: "Good CPU", price: 11_111)
Product.create(name: "Graphics Card", description: "Good Graphics Card", price: 111_111)

puts "Created #{Product.all.count} Products."
