class QuestionsController < ApplicationController
  def index
  	@questions = Question.all
    render json: @questions.to_json
  end

  def new
    user = User.first
    @question = Question.next_question(user)
    render json: @question.to_json
  end

  def create
  end

  private

  def question
    params[:question][:question]
  end
end
