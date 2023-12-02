class UsersController < ApplicationController
	skip_before_action :verify_authenticity_token
	before_action :extract_user_params, only:[:create]

	def index
		@users = User.all
		render json: @users.to_json
  	end

	def create
		puts @user.to_json
		@user.save!
		render json: {response: { status: "User created successfully!" }} 
	end

	def new 
		user = User.new
		render json: user.to_json
	end

	def delete
		user_id = params[:user_id]
		User.delete(user_id)
		render json: {response: { status: "User deleted successfully!" }} 
	end

	def current_user
		user = User.last
		render json: { response: { user_id: user.id} }
	end

	private

	def extract_user_params
		puts '!!! Extracting parameters for User!!!'
		@user = User.new
		@user.name = params[:name]
		@user.email = params[:email]
		@user.country = params[:country]
		@user.question_offset = 0
		@user.size = params[:size]
	end
end
