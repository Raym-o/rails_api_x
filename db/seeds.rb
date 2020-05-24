count = 1

10.times do
  f_name = Faker::Name.unique.first_name
  l_name = Faker::Name.unique.last_name
  username = f_name + count.to_s
  User.create(f_name: f_name, l_name: l_name, username: username, email: username + '@gmail.com', password: 'A123b')
  count += 1
end
