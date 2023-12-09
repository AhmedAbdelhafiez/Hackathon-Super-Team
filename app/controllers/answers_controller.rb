require 'net/http'
require 'json'

# app/controllers/answers_controller.rb
class AnswersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_user_data
  before_action :extract_answer_data

  # Reply with answer
  # Post Request
  # Input: user_id     -> integer
  #        answer      -> string 
  #        question_id -> integer
  # Output: status -> json
  def post_answer
    if @user.question_offset == @answer.question_id
      Rails.logger.info "Submitting Answer #{@answer.text} for Question #{@user.question_offset}"
      if @user.question_offset == Question.questions_limit
        Rails.logger.info "User #{@user.id} reached the limit of Questions"
        @answer.save!
        question = "This is a client's new business idea: #{@user.generate_summary} Based on the provided context, Do you find any similarities with Trianglz saved projects? if you find please provide me with the most similar project name and description. If you did not find a perfect match for me don not recommend anything, just tell me no perfect match. Ok!"
        response = QuestionService.new(question,nil,0).call
        return render json: response.to_json
      end
      @answer.save!
      return render json: { status: 200 }
    end
    return render json: { status: 500 }
  end

  # Refine answer
  # GET Request
  # Input: user_id     -> integer
  #        question_id -> integer
  # Output: status -> json
  def get_answer
    question_id = params[:question_id]
    Rails.logger.info "Getting Answer for Question: #{question_id}"
    answer = @user.answers.where("question_id = ?", question_id).first
    return render json: { answer: answer.text} unless answer.nil?
    return render json: { status: 500 }
  end

  private

  def set_user_data
    @user = User.find(params[:user_id])
  end

  def extract_answer_data
    @answer = Answer.new(
      user_id: @user.id,
      text: params[:answer],
      question_id: params[:question_id]
    )
  end
end