# puts "\n== Seeding the database with fixtures =="
# system("bin/rails db:fixtures:load")


Company.create(name: 'KPMG')
Company.create(name: 'PwC')

Quote.create(company_id: Company.find_by(name: 'KPMG').id, name: 'First quote')
Quote.create(company_id: Company.find_by(name: 'KPMG').id, name: 'Second quote')
Quote.create(company_id: Company.find_by(name: 'KPMG').id, name: 'Third quote')

today_date = Date.current
next_week_date = Date.current + 1.week

today_line_item_date = LineItemDate.create(quote_id: Quote.find_by(name: 'First quote').id, date: today_date)
next_week_line_item_date = LineItemDate.create(quote_id: Quote.find_by(name: 'First quote').id, date: next_week_date)

LineItem.create(line_item_date_id: today_line_item_date.id, name: 'Meeting room', description: 'A cosy meeting room for 10 people', quantity: 1, unit_price: 1000)
LineItem.create(line_item_date_id: today_line_item_date.id, name: 'Meal tray', description: 'Our delicious meal tray', quantity: 10, unit_price: 25)

LineItem.create(line_item_date_id: next_week_line_item_date.id, name: 'Meeting room', description: 'A cosy meeting room for 10 people', quantity: 1, unit_price: 1000)
LineItem.create(line_item_date_id: next_week_line_item_date.id, name: 'Meal tray', description: 'Our delicious meal tray', quantity: 10, unit_price: 25)

User.create(company_id: Company.find_by(name: 'KPMG').id, email: 'accountant@kpmg.com', encrypted_password: Devise::Encryptor.digest(User, 'password'))
User.create(company_id: Company.find_by(name: 'KPMG').id, email: 'manager@kpmg.com', encrypted_password: Devise::Encryptor.digest(User, 'password'))
User.create(company_id: Company.find_by(name: 'PwC').id, email: 'eavesdropper@pwc.com', encrypted_password: Devise::Encryptor.digest(User, 'password'))
