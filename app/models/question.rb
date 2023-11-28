class Question < ApplicationRecord
  validates :content, presence: true
  
  def self.next_question(user)
  	user.increment_offset
  	Question.find(user.question_offset).content
  end
end
