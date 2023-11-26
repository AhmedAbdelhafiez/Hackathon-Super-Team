DATA = [
  ['Project 1', 'Medical field'],
  ['Project 2', 'Ordering field'],
  ['Project 3', 'Educational field'],
  # ...
]

desc 'Fills database with data and calculate embeddings for each item.'
task index_data: :environment do
  openai_client = OpenAI::Client.new

  DATA.each do |item|
    page_name, text = item

    response = openai_client.embeddings(
      parameters: {
        model: 'text-embedding-ada-002',
        input: text
      }
    )

    embedding = response.dig('data', 0, 'embedding')

    Item.create!(page_name: page_name, text: text, embedding: embedding)

    puts "Data for #{page_name} created!"
  end
end
