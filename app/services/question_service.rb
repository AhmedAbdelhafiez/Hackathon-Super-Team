# frozen_string_literal: true

class QuestionService
  attr_reader :question
  attr_reader :response_type
  RESPONSELAYOUTS = [
    "Response will be in json format with three fields response and video
      the first field is response will be like Great news! We've got a ton of experience in this business concept. Let me tell you about our product
      the second field is product which consists of name and summary in 3 lines maximum 
      the third one is a video",
    "Response will be in json format with only one field response"
  ]
  def initialize(question, response_type)
    @question = question
    @response_layout = RESPONSELAYOUTS[response_type]
  end

  def call()
    message_to_chat_api(<<~CONTENT)
      You are website for a software company called Trianglz, located in Alexandria Egypt
      You are reciveing requests from clients to build a software product  
      Answer the following question without yes or no in a simplififed way maximum 3 lines.
      #{@response_layout}
      Based on the context below
      Context:
      #{context}
      ---
      Question: #{question}
    CONTENT
  end

  private

  def message_to_chat_api(message_content)
    if response_type
      return nil 
    end
    response = openai_client.chat(parameters: {
      model: 'gpt-3.5-turbo-1106',
      messages: [{ role: 'user', content: message_content }],
t    })
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
