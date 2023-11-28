class User < ApplicationRecord
  # Add the new column to the list
  attr_accessible :question_offset
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :question_offset, presence: true
  
  
  def increment_offset
  	self.question_offset++
  end
end
