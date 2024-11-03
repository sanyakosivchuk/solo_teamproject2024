require 'faker'

admin_user = User.create!(
  email: 'admin@admin.com',
  password: 'password',
  password_confirmation: 'password',
  role: :admin
)

default_user = User.create!(
  email: 'user@user.com',
  password: 'password',
  password_confirmation: 'password',
  role: :default
)

categories = 10.times.map do
  Category.create!(name: Faker::Book.genre)
end

10.times do
  category = categories.sample
  blog = Blog.create!(
    title: Faker::Book.title,
    content: Faker::Lorem.paragraph(sentence_count: 5),
    user: default_user,
    category: category
  )

  10.times do
    Post.create!(
      content: Faker::Lorem.paragraph(sentence_count: 10),
      blog: blog,
      user: default_user
    )
  end
end

Blog.reindex

puts "Seed data created successfully!"
