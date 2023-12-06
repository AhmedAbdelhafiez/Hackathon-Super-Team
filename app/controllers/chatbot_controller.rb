require 'net/http'
require 'json'

# app/controllers/chatbot_controller.rb
class ChatbotController < ApplicationController
  skip_before_action :verify_authenticity_token
  # protect_from_forgery with: :null_session
  before_action :set_user_data
  
  # Retrieve question from system
  def get_question
 	  @question = Question.next_question(@user)
    if @question.nil?
      render json: { response: "No Questions!"}
    end
    # Prepare data to be sent in the request body
    data_to_send = { id: @question.id, question: @question.content }
    request.body = data_to_send.to_json
    render json: data_to_send.to_json
  end

  # Reply on question
  # Post Request
  # Input: question -> string
  # Output: answer -> json
  def post_question
    question = params[:question]
    answer = QuestionService.new(question,0).call()
    
    render json: answer
  end

  # Reply with answer
  # Post Request
  # Input: user_id -> integer
  #        answer  -> string 
  # Output: status -> json
  def post_answer
    user_id = params[:user_id].to_i
    name = User.find(user_id).name
    answer = params[:answer]
    IndexData.new(user_id, name, answer).call

    render json: {status: 200}
  end

  # User report
  # Get Request
  # Input: user_id -> integer
  # Output: report -> json
  def user_report
    user_id = params[:user_id].to_i
    report = GenerateUserReport.new(user_id).call
    render json: {report: report}
  end

  private

  def set_user_data
    #@user = User.find(params[:id])
    @user = User.last
  end
end