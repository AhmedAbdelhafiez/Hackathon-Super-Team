class QuestionsController < ApplicationController
  def index
  	@questions = Question.all
    get
  end

  def new
    user = User.first
    @question = Question.next_question(user)
  end

  def create
    @answer = AnswerQuestion.new(question).call
  end

  private

  def question
    params[:question][:question]
  end
end
