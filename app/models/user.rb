class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_many :answers, dependent: :destroy

  def self.system_user
    User.first
  end

  def increment_offset
  	self.question_offset = self.question_offset + 1
    self.save!
  end

  def generate_summary
    answers = get_user_answers
    puts "answers!!!!"
    answers.join(",")
  end

  def generate_simplified_summary
     # Call open AI
  end
  
  def get_answers
    self.answers.order(:question_id).pluck(:text)
  end
end
