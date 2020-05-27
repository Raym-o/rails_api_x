count = 1
addr_count = true

USER_COUNT = 10
ADDRESS_COUNT = USER_COUNT

address_array = []
ADDRESS_COUNT.times do
  temp_address = Address.new
  temp_address[:line_1] = Faker::Address.unique.street_address
  temp_address[:line_2] = Faker::Address.unique.secondary_address if addr_count
  temp_address[:city] = Faker::Address.unique.city
  temp_address[:province] = Faker::Address.unique.state
  temp_address[:postal_code] = Faker::Address.unique.zip
  address_array.push(temp_address)
  addr_count = !addr_count
end

USER_COUNT.times do
  f_name = Faker::Name.unique.first_name
  l_name = Faker::Name.unique.last_name
  username = f_name + count.to_s
  u = User.new(f_name: f_name, l_name: l_name, username: username, email: username + '@gmail.com', password: 'A123b')

  u.address = address_array.pop if u.save

  count += 1
end

if Rails.env.development?
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
end
