class QuestionsController < ApplicationController
  def index
  end

  def create
  	message_content = <<~CONTENT
	  	Answer the question based on the context below, and
	  	if the question can't be answered based on the context,
	  	say \"I don't know\".

	  	Context:
	  	#{context}

	  	---

	  	Question: #{question}
	CONTENT
	openai_client = OpenAI::Client.new
	response = openai_client.chat(parameters: {
	  model: "gpt-3.5-turbo",
	  messages: [{ role: "user", content: message_content }],
	  temperature: 0.5,
	})
	#@answer = response.dig("choices", 0, "message", "content")
	response = openai_client.embeddings(
	  parameters: {
	    model: 'text-embedding-ada-002',
	    input: 'Rubyroid Labs has been on the web and mobile...'
	  }
	)

	response.dig('data', 0, 'embedding') # [0.0039921924, -0.01736092, -0.015491072, ...]
  end

  private

  def question
    params[:question][:question]
  end
end
