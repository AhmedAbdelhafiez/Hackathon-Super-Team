class Question < ApplicationRecord
  validates :content, presence: true
  validates :user_id, presence: true

  def self.next_question(user)
  	user.increment_offset
    begin
      Question.find(user.question_offset)
    rescue ActiveRecord::RecordNotFound => e
      nil
    end
  end
end
