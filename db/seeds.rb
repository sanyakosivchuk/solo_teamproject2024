require 'faker'

user = User.create!(
  email: 'admin@admin.com',
  password: 'password',
  password_confirmation: 'password',
  role: :admin
)

user = User.create!(
  email: 'user@user.com',
  password: 'password',
  password_confirmation: 'password',
  role: :default
)

10.times do
  blog = Blog.create!(
    title: Faker::Book.title,
    content: Faker::Lorem.paragraph(sentence_count: 5),
    user: user
  )

  10.times do
    Post.create!(
      content: Faker::Lorem.paragraph(sentence_count: 10),
      blog: blog,
      user: user
    )
  end
end

Blog.reindex
Post.reindex
puts "Seed data created successfully!"
