class Question < ApplicationRecord
  validates :content, presence: true
  validates :user_id, presence: true

  QUESTIONS = [
    "From trianglZ's past experience, could you estimate the anticipated timeline for the project I've just presented to you?",
    "For the project idea I've just presented to you now, provide me with global competitors filtered by competitors in the same country if they exist?",
    "From trianglz past project experience and the competitors mentioned, provide me with a list of features that can be implemented for a software platform. In bullet points format."
  ]
  def self.next_question(user)
  	user.increment_offset
    begin
      Question.find(user.question_offset)
    rescue ActiveRecord::RecordNotFound => e
      nil
    end
  end
end
