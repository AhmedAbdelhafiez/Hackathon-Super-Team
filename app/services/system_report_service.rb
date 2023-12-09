# frozen_string_literal: true

class SystemReportService
  
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
      User.where("status = ?", User.statuses["Completed"]).count
    end

    def _not_completed
      User.where("status = ?", User.statuses["NotCompleted"]).count
    end

    def _in_progress
      User.where("status = ?", User.statuses["InProgress"]).count
    end

    def _to_do
      User.where("status = ?", User.statuses["ToDo"]).count
    end
  end
  
  # GenerateSystemReport.new("Yours question..").call
  