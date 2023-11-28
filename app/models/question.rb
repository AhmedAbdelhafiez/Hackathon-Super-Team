class Question < ApplicationRecord
  validates :content, presence: true
  
  def next_question(user)
  	nxt_question = Question.find(user.question_offset).content
  	user.increment_offset
  	nxt_question
  end
end
