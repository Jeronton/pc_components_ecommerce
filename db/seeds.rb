Product.delete_all
Category.delete_all

cpucategory = Category.create(name: "CPU's", description: "All the best CPU's you could dream of!")
graphicscategory = Category.create(name:        "Graphics",
                                   description: "All your Graphic needs!")

cpucategory.products.create(name: "CPU", description: "Good CPU", price: 11_111)
graphicscategory.products.create(name: "Graphics Card", description: "Good Graphics Card",
price: 111_111)

puts "Created #{Product.all.count} Products."
puts "Created #{Category.all.count} Categories."
# puts "Created #{Product.all.count} Products."
# puts "Created #{Product.all.count} Products."
# puts "Created #{Product.all.count} Products."
