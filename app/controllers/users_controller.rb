class UsersController < ApplicationController
	def index
		@users = User.all
		puts "!!!Clearing offset!!!"
		User.first.update(question_offset: 0)
  	end
end
