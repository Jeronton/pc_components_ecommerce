Product.delete_all
Category.delete_all
Province.delete_all

cpucategory = Category.create(name: "CPU's", description: "All the best CPU's you could dream of!")
graphicscategory = Category.create(name:        "Graphics",
                                   description: "All your Graphic needs!")

cpucategory.products.create(name: "CPU", description: "Good CPU", price: 11_111)
graphicscategory.products.create(name: "Graphics Card", description: "Good Graphics Card",
price: 111_111)

mb = Province.create(abbreviation: "MB", name: "Manitoba", PST: 0.07, GST: 0.05)
ab = Province.create(abbreviation: "AB", name: "Alberta", GST: 0.05)

puts "Created #{Product.all.count} Products."
puts "Created #{Category.all.count} Categories."
puts "Created #{Province.all.count} Provinces."
# puts "Created #{Product.all.count} Products."
# puts "Created #{Product.all.count} Products."
