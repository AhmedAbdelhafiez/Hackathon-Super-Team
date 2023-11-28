class ApplicationController < ActionController::Base
	def index
		puts "!!!Clearing offset!!!"
		User.first.update(question_offset: 0)
	end
end
