# puts "\n== Seeding the database with fixtures =="
# system("bin/rails db:fixtures:load")


puts "\n== Seeding the database =="

begin
  # Creating companies
  kpmg = Company.create!(name: 'KPMG')
  pwc = Company.create!(name: 'PwC')
  puts "Created companies: #{kpmg.name}, #{pwc.name}"

  # Creating quotes
  quote1 = Quote.create!(company_id: kpmg.id, name: 'First quote')
  quote2 = Quote.create!(company_id: kpmg.id, name: 'Second quote')
  quote3 = Quote.create!(company_id: kpmg.id, name: 'Third quote')
  puts "Created quotes for KPMG"

  # Creating line item dates
  today_date = Date.current
  next_week_date = today_date + 1.week

  today_line_item_date = LineItemDate.create!(quote_id: quote1.id, date: today_date)
  next_week_line_item_date = LineItemDate.create!(quote_id: quote1.id, date: next_week_date)
  puts "Created line item dates for 'First quote'"

  # Creating line items
  LineItem.create!(line_item_date_id: today_line_item_date.id, name: 'Meeting room', description: 'A cosy meeting room for 10 people', quantity: 1, unit_price: 1000)
  LineItem.create!(line_item_date_id: today_line_item_date.id, name: 'Meal tray', description: 'Our delicious meal tray', quantity: 10, unit_price: 25)

  LineItem.create!(line_item_date_id: next_week_line_item_date.id, name: 'Meeting room', description: 'A cosy meeting room for 10 people', quantity: 1, unit_price: 1000)
  LineItem.create!(line_item_date_id: next_week_line_item_date.id, name: 'Meal tray', description: 'Our delicious meal tray', quantity: 10, unit_price: 25)
  puts "Created line items for 'First quote'"

  # Creating users
  User.create!(company_id: kpmg.id, email: 'accountant@kpmg.com', encrypted_password: Devise::Encryptor.digest(User, 'password'))
  User.create!(company_id: kpmg.id, email: 'manager@kpmg.com', encrypted_password: Devise::Encryptor.digest(User, 'password'))
  User.create!(company_id: pwc.id, email: 'eavesdropper@pwc.com', encrypted_password: Devise::Encryptor.digest(User, 'password'))
  puts "Created users for KPMG and PwC"

rescue ActiveRecord::RecordInvalid => e
  puts "Error seeding data: #{e.message}"
end

puts "Seeding completed."
