# frozen_string_literal: true

class AnswerQuestion
  attr_reader :question

  def initialize(question)
    @question = question
  end

  def call
    message_to_chat_api(<<~CONTENT)
      You are a chatbot in a software company website 
      Answer the question in a simplified way based on the context below
      And if you have a compelete vision about the idea reply
      with message "got it"
      Context:
      #{context}

      ---

      Question: #{question}
    CONTENT
  end

  private

  def message_to_chat_api(message_content)
    response = openai_client.chat(parameters: {
      model: 'gpt-3.5-turbo-1106',
      messages: [{ role: 'user', content: message_content }],
      temperature: 0.5
    })
    response.dig('choices', 0, 'message', 'content')
  end

  def context
    question_embedding = embedding_for(question)
    nearest_items = Item.nearest_neighbors(
      :embedding, question_embedding,
      distance: "euclidean"
    )
    context = nearest_items.first&.text
  end

  def embedding_for(text)
    response = openai_client.embeddings(
      parameters: {
        model: 'text-embedding-ada-002',
        input: text
      }
    )
    puts "!!Get Embedding!!"
    response.dig('data', 0, 'embedding')
  end

  def openai_client
    @openai_client ||= OpenAI::Client.new
  end
end

# AnswerQuestion.new("Yours question..").call
