User.all.each do |user|
  user.posts.create!(
    content: Faker::Hacker.say_something_smart,
    remote_images_urls: %w[https://picsum.photos/350/350/?random https://picsum.photos/350/350/?random]
  )
end