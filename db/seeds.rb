OrderProduct.delete_all
Product.delete_all
Category.delete_all
Order.delete_all
Customer.delete_all
Province.delete_all

cpucategory = Category.create(name: "CPU's", description: "All the best CPU's you could dream of!")
graphicscategory = Category.create(name:        "Graphics",
                                   description: "All your Graphic needs!")

cpu = cpucategory.products.create(name: "Intel Core Duo",
description: "Why would anyone want to buy this?", price: 199)
cpucategory.products.create(name: "AMD Rysen 3600",
description: "6-Core 12-Thread Unlocked", price: 21_111)
cpucategory.products.create(name: "Intel I9-9900K", description: "8 Cores up to 5.0Ghzs",
price: 51_111)
cpucategory.products.create(name: "Intel I7-10700K", description: "8 Cores up to 5.1Ghzs",
price: 411_111)
cpucategory.products.create(name: "Intel I5-10400", description: "6 Cores up to 4.3 Ghzs",
price: 22_111)
graphicscategory.products.create(name: "GeForce RTX 3070", description: "Ultra gaming, 8GB GDDR6.",
price: 111_111)
graphicscategory.products.create(name: "GeForce RTX 3080", description: "
  Chipset: NVIDIA GeForce RTX 3080
  Triple Fan Thermal Design
  Video Memory: 10GB GDDR6X
  Memory Interface: 320-bit
  Output: DisplayPort x 3 (v1.4a) / HDMI 2.1 x 1
",
  price: 111_111)
graphicscategory.products.create(name: "EVGA GeForce RTX 3090", description: "
  Real boost clock: 1800 MHz; Memory detail: 24576 MB GDDR6X.
  Real-time ray tracing in games for cutting-edge, hyper-realistic graphics.
  Triple HDB fans + 9 iCX3 thermal sensors offer higher performance cooling and much quieter acoustic noise.
  All-metal backplate & adjustable ARGB
  3 year warranty & EVGA's top notch technical support.
",
  price: 111_111)
graphicscategory.products.create(name: "ASUS GeForce RTX 2060", description: " Powered by NVIDIA Turing with 1785 MHz Boost Clock, 1920 CUDA cores and overclocked 6GB GDDR6 memory
  Supports up-to 4 monitors with DisplayPort 1. 4, HDMI 2. 0 and DVI ports
  Wing-Blade Fans boasts IP5X dust-resistance and operates at 0 dB levels when temperatures hit below 55C.
  Protective Backplate features a durable aluminum construction to prevent PCB flex and trace damage.
  GPU Tweak II makes monitoring performance and streaming in real time easier than ever, and includes additional software like",
  price: 111_111)
graphicscategory.products.create(name: "NVIDIA GTX 1050", description: "
  4GB of memory
  2x 80 mm fans
  Dual-link DVI-D, HDMI, and Display ports
  7680 x 4320 resolution
  One-click super overclocking
",
  price: 111_111)

#  Add Provinces
mb = Province.create(abbreviation: "MB", name: "Manitoba", PST: 0.07, GST: 0.05)
ab = Province.create(abbreviation: "AB", name: "Alberta", GST: 0.05)

mb = Province.create(abbreviation: "BC", name: "British Columbia", PST: 0.07, GST: 0.05)
mb = Province.create(abbreviation: "NB", name: "New Brunswick", HST: 0.15)
mb = Province.create(abbreviation: "NL", name: "Newfoundland and Labrador", HST: 0.15)
mb = Province.create(abbreviation: "NT", name: "Northwest Territories", GST: 0.05)
mb = Province.create(abbreviation: "NS", name: "Nova Scotia", HST: 0.15)
mb = Province.create(abbreviation: "NU", name: "Nunavut", GST: 0.05)
mb = Province.create(abbreviation: "ON", name: "Ontario", HST: 0.13)
mb = Province.create(abbreviation: "PE", name: "Prince Edward Island", HST: 0.15)
mb = Province.create(abbreviation: "QC", name: "Quebec", PST: 0.09975, GST: 0.05)
mb = Province.create(abbreviation: "SK", name: "Saskatchewan", PST: 0.06, GST: 0.05)
mb = Province.create(abbreviation: "YT", name: "Yukon", GST: 0.05)

jeremy = mb.customers.create(first_name: "Jeremy", last_name: "Grift", phone: "204-222-3333",
  email: "jeremy@test.com", country: "Canada", city: "Anola", address_line1: "123 somewhere st", postal: "A1B2C3")

ab.customers.create(first_name: "Bob", last_name: "Jones", phone: "204-222-5555",
  email: "bob@test.com", country: "Canada", city: "City", address_line1: "321 somewhere st", postal: "H6B2Y3")

# order = jeremy.orders.create(total: 1234, status: "Pending", HST: 11)
# OrderProduct.create(order: order, product: cpu, price: 1234, quantity: 1)

puts "Created #{Product.all.count} Products."
puts "Created #{Category.all.count} Categories."
puts "Created #{Province.all.count} Provinces."
puts "Created #{Customer.all.count} Customers."
puts "Created #{OrderProduct.all.count} ProductOrders."
puts "Created #{Order.all.count} Orders."

# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
