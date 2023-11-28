class QuestionsController < ApplicationController
  def index
  	@questions = Question.all
  end

  def get
    @question = question.first
  end

  def create
    @answer = AnswerQuestion.new(question).call
  end

  private

  def question
    params[:question][:question]
  end
end
