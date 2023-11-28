class User < ApplicationRecord
  # Add the new column to the list
  attr_accessor :first_name
  attr_accessor :las_name
  attr_accessor :email
  attr_accessor :question_offset
  
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :question_offset, presence: true
  
  
  def increment_offset
  	puts "Offset - " 
  	puts self.question_offset 
  	self.question_offset = self.question_offset + 1
  end
end
