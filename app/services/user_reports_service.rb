# frozen_string_literal: true

class UserReportsService
    attr_reader :user_id
  
    def initialize(user_id)
        @user = User.find(user_id)
    end
  
    def generate
      return {
        user: @user,
        summary: _prepare_summary,
        answers: _prepare_answers
      }
      
    end

    private

    def _prepare_summary
      @user.generate_summary
    end

    def _prepare_answers
      @user.get_answers
    end
  end
  
  # GenerateReport.new("Yours question..").call
  