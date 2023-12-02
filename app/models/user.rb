class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def self.system_user
    User.first
  end

  def increment_offset
  	self.question_offset = self.question_offset + 1
    self.save!
  end
end
