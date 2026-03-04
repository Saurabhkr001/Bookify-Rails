# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
# Create standard users


# 10.times do |i|
#   User.create!(
#     name: "Library Member #{i + 1}",
#     email: "member#{i + 1}@library.com",
#     password: "password123",
#     password_confirmation: "password123",
#     role: "member"
#   )
# end

# User.create!(
#   name: "Main Librarian",
#   email: "librarian@library.com",
#   password: "libpass",
#   password_confirmation: "libpass",
#   role: "librarian"
# )

# puts "Created #{User.count} users"