Product.delete_all
Category.delete_all
Customer.delete_all
Province.delete_all

cpucategory = Category.create(name: "CPU's", description: "All the best CPU's you could dream of!")
graphicscategory = Category.create(name:        "Graphics",
                                   description: "All your Graphic needs!")

cpucategory.products.create(name: "CPU", description: "Good CPU", price: 11_111)
graphicscategory.products.create(name: "Graphics Card", description: "Good Graphics Card",
price: 111_111)

mb = Province.create(abbreviation: "MB", name: "Manitoba", PST: 0.07, GST: 0.05)
ab = Province.create(abbreviation: "AB", name: "Alberta", GST: 0.05)

mb.customers.create(first_name: "Jeremy", last_name: "Grift", phone: "204-222-3333",
  email: "jeremy@test.com", country: "Canada", city: "Anola", address_line1: "123 somewhere st", postal: "A1B2C3")

ab.customers.create(first_name: "Bob", last_name: "Jones", phone: "204-222-5555",
  email: "bob@test.com", country: "Canada", city: "City", address_line1: "321 somewhere st", postal: "H6B2Y3")

puts "Created #{Product.all.count} Products."
puts "Created #{Category.all.count} Categories."
puts "Created #{Province.all.count} Provinces."
puts "Created #{Customer.all.count} Customers."
# puts "Created #{Product.all.count} Products."
