class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_many :answers, dependent: :destroy
  has_many :reports, dependent: :destroy

  enum :status, {
    Pending: 0,
    Inprogress: 1,
    Completed: 2,
    NotCompleted: 3,
    ToDo: 4
  }, default: :Pending, prefix: true, scopes: false
  
  def self.system_user
    User.first
  end
  
  def increment_offset
    self.status = User.statuses["Inprogress"]
    if self.question_offset < Question.questions_limit
      self.question_offset = self.question_offset + 1
      self.save!
      return 
    end
    self.status = User.statuses["NotCompleted"]
    self.save!
  end

  def generate_summary
    get_answers.join(",")
  end

  def generate_simplified_summary
    # Call open AI
    "I need to have a product in Health Care sector that serve patients appointments and allow them to schedule them"
  end
  
  def get_answers
    self.answers.order(:question_id).pluck(:text)
  end
end
