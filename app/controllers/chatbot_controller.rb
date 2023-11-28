#      // Retrieve the answer via a GET request
#      const response = await axios.get('http://localhost:3000/api/answer');

require 'net/http'
require 'json'

# app/controllers/chatbot_controller.rb
class ChatbotController < ApplicationController
  # before_action :set_user_data, only: [:send_question]
  
  def get_question
 	set_user_data
  	send_question
  end
  
  def send_question
    uri = URI.parse('http://your-react-api-endpoint.com/api/data')  # Replace with your React API endpoint

    # Create a Net::HTTP object
    http = Net::HTTP.new(uri.host, uri.port)

    # Create a request
    request = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/json'})
	
    @question = Question.next_question(@user)
    
    # Prepare data to be sent in the request body
    data_to_send = { question: @question }
    request.body = data_to_send.to_json

    # Make the request
    response = http.request(request)

    # Process the response
    if response.code.to_i == 200
      # Request was successful
      parsed_response = JSON.parse(response.body)
      # Process the parsed_response as needed
    else
      # Handle error case
      puts "Error: #{response.code} - #{response.body}"
    end

    render json: { status: 'Request sent successfully' }
  end

  def get_answer
    # Retrieve the stored question (you may want to fetch it from a database)
    # For simplicity, we are retrieving it from an instance variable here
    question = @question
    answer = params[:question]

    AnswerQuestion.new(question).call
    # Process the question and generate an answer
    # For simplicity, we are returning a hardcoded answer here
    answer = "The answer to '#{question}' is 42."

    render json: { answer: answer }
  end

  private

  def set_user_data
    #@user = User.find(params[:id])
    @user = User.first
    # You can perform any user-specific actions here before handling the question
  end
end

