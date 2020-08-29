require 'uri'
require 'json'
require 'pry'
require 'net/http'

count = 1
addr_count = true

USER_COUNT = 10
ADDRESS_COUNT = USER_COUNT

provinces = [
  { name: 'Alberta', abbr: 'AB', pst_rate: 0, hst_rate: 0 },
  { name: 'British Columbia', abbr: 'BC', pst_rate: 0.07, hst_rate: 0 },
  { name: 'Manitoba', abbr: 'MB', pst_rate: 0.07, hst_rate: 0 },
  { name: 'New Brunswick', abbr: 'NB', pst_rate: 0, hst_rate: 0.1 },
  { name: 'Newfoundland and Labrador', abbr: 'NL', pst_rate: 0, hst_rate: 0.1 },
  { name: 'Nova Scotia', abbr: 'NS', pst_rate: 0, hst_rate: 0.1 },
  { name: 'Northwest Territories', abbr: 'NT', pst_rate: 0, hst_rate: 0 },
  { name: 'Nunavut', abbr: 'NU', pst_rate: 0, hst_rate: 0 },
  { name: 'Ontario', abbr: 'ON', pst_rate: 0, hst_rate: 0.08 },
  { name: 'Prince Edward Island', abbr: 'PE', pst_rate: 0, hst_rate: 0.1 },
  { name: 'Quebec', abbr: 'QC', pst_rate: 0.09975, hst_rate: 0 },
  { name: 'Saskatchewan', abbr: 'SK', pst_rate: 0.06, hst_rate: 0 },
  { name: 'Yukon', abbr: 'YT', pst_rate: 0, hst_rate: 0 }
]

provinces.each do |p|
  Province.create(
    name: p[:name],
    abbr: p[:abbr],
    pst_rate: p[:pst_rate],
    hst_rate: p[:hst_rate]
  )
end

province_cnt = 1
address_array = []
ADDRESS_COUNT.times do
  temp_address = Address.new
  temp_address[:line_1] = Faker::Address.unique.street_address
  temp_address[:line_2] = Faker::Address.unique.secondary_address if addr_count
  temp_address[:city] = Faker::Address.unique.city
  temp_address[:province_id] = province_cnt
  temp_address[:postal_code] = Faker::Address.unique.zip
  address_array.push(temp_address)
  addr_count = !addr_count
  province_cnt += 1
end

USER_COUNT.times do
  f_name = Faker::Name.unique.first_name
  l_name = Faker::Name.unique.last_name
  username = f_name + count.to_s
  u = User.new(f_name: f_name, l_name: l_name, username: username, email: username + '@gmail.com', password: 'A123b')

  u.address = address_array.pop if u.save

  count += 1
end

file = File.open('../../jtg_data.json')
data = JSON.load file

data.each do |dat|
  # container for image details to loop through attaching images at the end
  a_temp_images = []

  p = Product.new(
    title: dat['title'],
    price: dat['price'],
    description: dat['description']['main_description']
  )
  # img_url = 'https:' + img.slice(img.index("'") + 1, (img.rindex("'") - img.index("'") - 1))
  dat['image'].each do |_k, v|
    ct = 0
    temp_image = {}
    v.each do |kk, vv|
      if kk == 'src'
        image_url = 'https:' + vv
        temp_image[:url] = image_url
        # p.images.attach(io: URI.open(image_url))
      end
      next unless kk == 'alt'

      temp_image[:alt] = vv + ct.to_s
      ct += 1
      next if temp_image[:url].nil?

      input_image = {}
      input_image[:url] = temp_image[:url]
      input_image[:alt] = temp_image[:url]
      a_temp_images.push(input_image)

      temp_image[:url] = nil
      temp_image[:alt] = nil
    end
  end
  puts a_temp_images.count
  a_temp_images.each do |image|
    puts '...'
    puts image[:url]
    puts ',,,'

    my_url = URI.parse(image[:url])
    req = Net::HTTP.new(my_url.host, my_url.port)
    req.use_ssl = true
    res = req.request_head(my_url.path)

    puts 'content-type'
    puts res['content-type']
    puts 'content_type'
    if res['content-type'] == 'image/jpeg'
      p.images.attach(
        io: URI.open(image[:url]),
        filename: image[:alt],
        content_type: 'image/jpg',
        identify: false
      )
    end
    puts 'notnull'

    p.save!
    puts 'SAVING'
  end
end

if Rails.env.development?
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
end
