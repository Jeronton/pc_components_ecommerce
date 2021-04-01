Product.delete_all
Category.delete_all

Product.create(name: "CPU", description: "Good CPU", price: 11_111)
Product.create(name: "Graphics Card", description: "Good Graphics Card", price: 111_111)

Category.create(name: "CPU's", description: "All the best CPU's you could dream of!")

puts "Created #{Product.all.count} Products."
puts "Created #{Category.all.count} Categories."
# puts "Created #{Product.all.count} Products."
# puts "Created #{Product.all.count} Products."
# puts "Created #{Product.all.count} Products."
