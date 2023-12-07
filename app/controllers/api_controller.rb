require 'net/http'
require 'json'

# app/controllers/api_controller.rb
class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  # protect_from_forgery with: :null_session
  before_action :set_user_data
  before_action :extract_answer_params, only:[:post_answer]

  
  # Retrieve question from system
  def get_question
 	  @question = Question.next_question(@user)
    if @question.nil?
      render json: { response: "No Questions!"}
    end
    # Prepare data to be sent in the request body
    data_to_send = { id: @question.id, question: @question.content }
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
  # Input: user_id     -> integer
  #        answer      -> string 
  #        question_id -> integer
  # Output: status -> json
  def post_answer
    puts "Saving Answer into db #{@answer.text} for user #{@user.name}"
    @answer.save!
    render json: {status: 200}
  end

  # User report
  # Get Request
  # Input: user_id -> integer
  # Output: report -> json
  def user_report
    user_id = params[:user_id].to_i
    report = UserReportsService.new(user_id).generate
    render json: report.to_json
  end

  def system_report
    report = SystemReportsService.new.generate
    render json: report.to_json
  end

  private

  def set_user_data
    @user = User.find(params[:id])
    #@user = User.last
  end

  def extract_answer_params
    user_id = params[:user_id].to_i
    question_id = params[:question_id].to_i
    answer_text = params[:answer]
    @answer = Answer.new
    @answer.user_id = user_id
    @answer.question_id = question_id
    @answer.text = answer_text
  end
end