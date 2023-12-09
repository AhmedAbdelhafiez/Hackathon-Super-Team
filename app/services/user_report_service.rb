# frozen_string_literal: true

class UserReportService
    attr_reader :user_id
    attr_reader :report_type

    def initialize(user_id, report_type)
        @user = User.find(user_id)
        @report_type = report_type
    end

    def call()
      puts "!!!!REPORT TYPE #{@report_type}!!!!!"
      return generate if @report_type == 1
      generate_insights
    end

    def generate
      return {
        user: @user,
        summary: _prepare_summary,
        answers: _prepare_answers
      }
    end

    def generate_insights
      if @user.reports.empty?
        report = {
          user: @user,
          fit_culture: does_it_fit_culture,
          competitors: competitors,
          expected_duration: duration,
          recommended_features: features
        }
        _creat_new_report(report)
        return report
      end
      @user.reports.first
    end

    private

    def _creat_new_report(report)
      new_report = Report.new()
      new_report.content = report
      new_report.user_id = @user.id
      new_report.save!
    end
    def _prepare_summary
      @user.generate_summary
    end

    def _prepare_answers
      @user.get_answers
    end

    # To Do 
    def does_it_fit_culture
      sleep 3
      #question = "Could you tell me if this project is fitting my culture given in the context? Reply with one word Yes / No"
      #context = @user.generate_summary
      #QuestionService.new(nil,question,context,1).call
      "Yes"
    end

    def competitors
      sleep 3
      question = "Could you list the potential competitors for this project on a global scale ? Also a list of local competitors for this project located in #{@user.country}"
      context = @user.generate_summary
      QuestionService.new(nil,question,context,1).call
    end

    def duration
      sleep 3
      question = "Could you estimate the project duration based on the previous list of MVP features that you have listed and also the data provided without listing the time required for each feature"
      context = @user.generate_summary
      QuestionService.new(nil,question,context,1).call
    end

    def features
      sleep 3
      question = "Could you provide the list of MVP features that could be available in this project"
      context = @user.generate_simplified_summary
      QuestionService.new(nil,question,context,1).call
    end
  end
  
  # GenerateReport.new("Yours question..").call
  