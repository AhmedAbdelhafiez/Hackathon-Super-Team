# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


# db/seeds.rb

sys_user = User.create(name: "Ahmed Abdelhafiez", email: "Ahmed.Abdelhafiez@trianglz.com", country: "Egypt", source: "Facebook")

puts "Seed data for system user created successfully!"

questions = [
  "What’s your business idea category?",
  "What’s the primary focus or theme of your idea?",
  "Is it in existence or a new product?",
  "What’s your target audience?",
  "What features do you consider essential for the initial release of your product?",
  "What’s your expected duration"
  # Add more questions as needed
]

questions.each do |question_text|
  Question.create(content: question_text, user_id: sys_user.id)
end

puts "Seed data for questions created successfully!"
