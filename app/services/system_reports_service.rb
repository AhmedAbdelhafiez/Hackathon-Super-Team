# frozen_string_literal: true

class SystemReportsService
  
    def initialize()
      @users = User.all
    end
  
    def generate
      return {
        completed: _completed,
        not_completed: _not_completed,
        in_progress: _in_progress,
        to_do: _to_do,
        conversion_rate: _completed/_users_count
      }
    end
  
    private

    def _users_count
        User.count
    end

    def _completed
      User.where("question_offset = ?", 5).count
    end

    def _not_completed
      User.where("question_offset < ?", 5).count
    end

    def _in_progress
    end

    def _to_do
    end

  end
  
  # GenerateSystemReport.new("Yours question..").call
  