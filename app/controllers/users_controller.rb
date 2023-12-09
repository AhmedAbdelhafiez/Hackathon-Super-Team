class UsersController < ApplicationController
	skip_before_action :verify_authenticity_token
	before_action :extract_user_params, only:[:create]
	before_action :set_user_data, only:[:request_meeting, :get_insights]

	def index
		Rails.logger.info "Getting All Users informations"
		@users = User.select("id","name","email","title").all
		render json: @users.to_json
  	end

	def create
		Rails.logger.info "Creating User: #{@user.to_json}"
		@user.save!
		render json: {user_id: @user.id}
	end

	def get_user 
		Rails.logger.info "Getting User with id: #{params[:user_id]}"
		user = User.find(params[:user_id])
		render json: user.to_json
	end

	def delete
		user_id = params[:user_id]
		User.delete(user_id)
		render json: {response: { status: "User deleted successfully!" }} 
	end

	def current_user
		user = User.last
		render json: { user_id: user.id }
	end

	def dummy_user
		user = User.create(name: "NewUser", email: "New.User#{@user.id+1}@trianglz.com", country: "Egypt", source: "Facebook", question_offset: 0)
		render json: {new_user_id: user.id}
	end

	# GET Request
  	# Input: user_id  Integer
	def request_meeting
		Rails.logger.info "Request Meeting for User: #{@user.to_json}"
		@user.status = User.statuses["Completed"]
		@user.save!
    	UserMailer.send_meeting_email(@user).deliver_now
		render json: {status: "Request Sent"}
 	end

	# GET Request
	# Input: user_id Integer
	def get_insights
		Rails.logger.info "Getting Insights for User: #{@user.to_json}"
		report = UserReportService.new(@user.id, 0).call
		render json: report.to_json
	end

	private

	def extract_user_params
		@user = User.new(
			name: params[:name],
			email: params[:email],
			title: params[:title],
			country: params[:country],
			phone: params[:phone]
		)
	end

	def set_user_data
		user_id = params[:user_id]
		@user = User.find(user_id) unless user_id.nil?
	end
end
