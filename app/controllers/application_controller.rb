class ApplicationController < ActionController::Base
	def index
		User.first.update(question_offset: 0)
	end
end
