class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

def create
    # Construct the message content for the chat-based model
    chat_message = construct_chat_message(context, question)

    # Initialize OpenAI client
    openai_client = OpenAI::Client.new

    # Get the chat-based model response
    chat_response = openai_client.chat(parameters: {
      model: "gpt-3.5-turbo",
      messages: [{ role: "user", content: chat_message }],
      temperature: 0.5,
    })

    # Uncomment the line below if you want to retrieve the chat-based answer
    # @answer = chat_response.dig("choices", 0, "message", "content")
    # Get embeddings using the text-embedding-ada-002 model
    embeddings_response = openai_client.embeddings(
      parameters: {
        model: 'text-embedding-ada-002',
        input: 'Rubyroid Labs has been on the web and mobile...'
      }
    )

    # Process and return the embeddings
    embeddings = embeddings_response.dig('data', 0, 'embedding')
    render json: { embeddings: embeddings }
  end

  private

  # Helper method to construct the chat message
  def construct_chat_message(context, question)
    <<~CONTENT
      Answer the question based on the context below, and
      if the question can't be answered based on the context,
      say "I don't know".

      Context:
      #{context}

      ---

      Question: #{question}
    CONTENT
  end

  def question
    params[:question][:question]
  end
end
