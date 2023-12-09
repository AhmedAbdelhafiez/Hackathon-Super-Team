class QuestionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_user_data
 
  def index
  	@questions = Question.all
    render json: @questions.to_json
  end

  # Retrieve question from system
  def get
    Rails.logger.info "Get Next Question for User ID: #{@user.id}"
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
  #def post
  #  Rails.logger.info "Post Question: #{}"
  #  question = params[:question]
  #  answer = QuestionService.new(question,0).call()
  #  render json: answer
  #end

  private

  def set_user_data
		@user = User.find(params[:user_id])
	end
end
