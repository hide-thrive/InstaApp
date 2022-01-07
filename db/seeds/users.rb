5.times do |n|
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.unique.email(domain: 'example'),
    password: 'password',
    password_confirmation: 'password',
    avatar: Faker::Avatar.image(format: 'jpg')
  )
end