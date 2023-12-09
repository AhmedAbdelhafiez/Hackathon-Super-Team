# frozen_string_literal: true

class QuestionService
  attr_reader :background
  attr_reader :question
  attr_reader :context
  attr_reader :response_type

  BACKGROUND = "Trianglz is a software company that located in Alexandria Egypt
  You are a wizard integerated in company website and you are reciveing requests from clients to build a software product".freeze
    
  RESPONSELAYOUTS = [
    "Response will be in json format with three fields response and video
      the first field is response will be like Great news! We've got a ton of experience in this business concept. Let me tell you about our product
      the second field is product which consists of name and summary in 3 lines maximum starts with product name
      the third one is a video",
    "Act like a normal person"
  ]
  def initialize(background, question, context, response_type)
    @background = background || BACKGROUND
    @question = question
    @context = context
    @response_layout = RESPONSELAYOUTS[response_type]
  end

         
  def call()
    message_to_chat_api(<<~CONTENT)
      Based on the following information  
      Background:#{@background}
      Context:
      #{context}
      Reply on this question: #{@question} in this format #{@response_layout}
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
    return @context unless @context.nil?
    puts "!!!Start Getting Context from db!!!"
    question_embedding = EmbeddingService.new(question).call
    nearest_items = Item.nearest_neighbors(
      :embedding, question_embedding,
      distance: "euclidean"
    )
    unless nearest_items.empty?
      puts "!!!Found Items!!!! #{nearest_items.first&.text}"
      puts "!!!!"
      return nearest_items.first&.text
    end
    return @context
  end

  def openai_client
    @openai_client ||= OpenAI::Client.new
  end
end

# QuestionService.new("background"Yours question..", "context", "response_type").call
