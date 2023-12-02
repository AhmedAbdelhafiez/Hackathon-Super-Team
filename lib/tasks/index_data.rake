DATA = [
  [
    "Livy Method",
    "Trianglz is a software company that has a product called Livy Method, The Livy product is a 12-week weight loss app with a 91-day program. Users log daily meals, track progress, and access videos, posts, and guides on nutrition and exercises. Each week has a theme, ending with a motivational summary. After completing the program, users enter a maintenance period. They can communicate with mentors and connect with a community. The app's MVP features include daily logging, curated posts, weekly guides, progress tracking, social media sharing, and before-and-after photos. The program lasts for 6 months.",
    "123"
  ],
  [
    "mimar",
    "Trianglz is a software company that has a product called mimar \nDescription: Mimar helps you to book your appointments anytime, anywhere. You can browse for nearby providers with various categories such as beauty, health or wellness. You can check their availability, their staff, as well as checking what others said about them.\nNo need for picking up the phone, your appointment is only a few clicks away and our reminders will also make sure you never miss an appointment.",
    "456"
  ]
  # ...
]

desc 'Fills database with data and calculate embeddings for each item.'
task index_data: :environment do
  openai_client = OpenAI::Client.new

  DATA.each do |item|
    page_name, text, media = item

    response = openai_client.embeddings(
      parameters: {
        model: 'text-embedding-ada-002',
        input: text
      }
    )

    embedding = response.dig('data', 0, 'embedding')

    Item.create!(page_name: page_name, text: text, embedding: embedding, media: media, user_id: User.first.id)

    puts "Data for #{page_name} created!"
    sleep 30
  end
end
