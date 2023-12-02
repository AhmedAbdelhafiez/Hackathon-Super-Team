#      // Retrieve the answer via a GET request
#      const response = await axios.get('http://localhost:3000/api/answer');

require 'net/http'
require 'json'

# app/controllers/chatbot_controller.rb
class ChatbotController < ApplicationController
  skip_before_action :verify_authenticity_token
  # protect_from_forgery with: :null_session
  before_action :set_user_data
  
  # Retrieve question from chatbot
  def get_question
 	  set_user_data
    uri = URI.parse('http://your-react-api-endpoint.com/api/data')  # Replace with your React API endpoint

    # Create a Net::HTTP object
    http = Net::HTTP.new(uri.host, uri.port)

    # Create a request
    request = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/json'})
	
    @question = Question.next_question(@user)
    if @question.nil?
      render json: { response: "No Questions!"}
    end
    # Prepare data to be sent in the request body
    data_to_send = { id: @question.id, question: @question.content }
    request.body = data_to_send.to_json

    # Make the request
    #response = http.request(request)

    # Process the response
    #if response.code.to_i == 200
      # Request was successful
    #  parsed_response = JSON.parse(response.body)
      # Process the parsed_response as needed
    #else
      # Handle error case
    #  puts "Error: #{response.code} - #{response.body}"
    #end

    render json: data_to_send.to_json
  end

  # Reply on Question
  def post_question
    @question = params[:question]
    @answer = AnswerQuestion.new(@question).call
    render json: @answer.to_json
  end

  def post_answer
    # Chatbot_part
    #question_id = params[:question_id].to_i
    #puts Question.find(question_id).content
    #puts params[:answer]
    #render json: {status: 200}

    user_id = params[:user_id].to_i
    name = User.find(user_id).name
    answer = params[:answer]
    puts name
    puts answer
    IndexData.new(user_id, name, answer).call
    render json: {status: 200}
  end

  def new_user
    user = User.create(name: "NewUser", email: "New.User#{@user.id+1}@trianglz.com", country: "Egypt", source: "Facebook", question_offset: 0)
    render json: {new_user_id: user.id}
  end

  def user_report
    user_id = params[:user_id].to_i
    report = GenerateUserReport.new(user_id).call
    render json: {report: report}
  end

  private

  def set_user_data
    #@user = User.find(params[:id])
    @user = User.last
    # You can perform any user-specific actions here before handling the question
  end
end