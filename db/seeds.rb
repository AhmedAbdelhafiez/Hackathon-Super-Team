# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


# db/seeds.rb

questions = [
  "What is your name",
  "What is your email",
  "Where are you from?",
  # Add more questions as needed
]

questions.each do |question_text|
  Question.create(content: question_text)
end

puts "Seed data for questions created successfully!"

User.create(first_name: "Ahmed", last_name: "Abdelhafiez", email: "Ahmed.Abdelhafiez@trianglz.com", question_offset: 0)


puts "Seed data for users created successfully!"
