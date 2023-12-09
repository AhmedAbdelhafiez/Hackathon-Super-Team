require 'net/http'
require 'json'

# app/controllers/reports_controller.rb
class ReportsController < ApplicationController
  skip_before_action :verify_authenticity_token
  # protect_from_forgery with: :null_session
  before_action :set_user_data, only:[:user_report]

  # User report
  # Get Request
  # Input: user_id -> integer
  # Output: report -> json
  def user_report
    user_id = params[:user_id].to_i
    Rails.logger.info "Getting Report for user_id: #{user_id}"
    report = UserReportService.new(user_id,1).call
    render json: report.to_json
  end

  # System Analytics
  # GET Request
  def system_report
    Rails.logger.info "Getting System Report #{Time.now}"
    report = SystemReportService.new.generate
    render json: report.to_json
  end

  private

  def set_user_data
    @user = User.find(params[:user_id])
  end
end